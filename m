Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270528AbSISI4I>; Thu, 19 Sep 2002 04:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270558AbSISI4H>; Thu, 19 Sep 2002 04:56:07 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:27800 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S270528AbSISI4H>; Thu, 19 Sep 2002 04:56:07 -0400
Date: Thu, 19 Sep 2002 10:58:41 +0200
From: Dominik Brodowski <linux@brodo.de>
To: hpa@transmeta.com, linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: cpufreq for 2.5.36 now available
Message-ID: <20020919105841.A1586@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Updated patches for CPU frequency and voltage scaling support are now
available at

http://www.brodo.de/cpufreq/

Changes since the version submitted on lkml for 2.5.35:
- Documentation fixes (Hollis Blanchard, Xavier Bestel)
- longrun.c 0% performance does not mean 0 MHz but lowest available frequency


complete patch for kernel 2.5.36:
http://www.brodo.de/cpufreq/cpufreq-2.5.36-1.gz

step-by-step patches for kernel 2.5.36:
http://www.brodo.de/cpufreq/cpufreq-2.5.36-core-1
http://www.brodo.de/cpufreq/cpufreq-2.5.36-i386-core-1
http://www.brodo.de/cpufreq/cpufreq-2.5.36-i386-drivers-1
http://www.brodo.de/cpufreq/cpufreq-2.5.36-doc-1
http://www.brodo.de/cpufreq/cpufreq-2.5.36-24api-1

backport to kernel 2.4.19/2.4.20-pre7:
http://www.brodo.de/cpufreq/cpufreq-2.4.19-3.gz
http://www.brodo.de/cpufreq/cpufreq-2.4.20-pre7-3.gz

This cpufreq version is included in 2.4.-ac patchsets since
2.4.20-pre7-ac1, a few updates for -ac2 can be found here:
http://www.brodo.de/cpufreq/cpufreq-2.4.20-pre7-ac2-1

Comments welcome; please ensure that the cpufreq development list at
cpufreq@www.linux.org.uk receives a copy of all comments.


	Dominik
