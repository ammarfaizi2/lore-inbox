Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264093AbTEGP6c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264094AbTEGP4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:56:51 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:4584 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id S264093AbTEGP4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:56:44 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: Re: CPUFreq sysfs interface MIA? (since 2.5.69)
Date: Wed, 7 May 2003 18:09:12 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305071809.12961.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Under both 2.5.68 and 2.5.69 the CPUFreq /sys interface seems to be
> missing for my machine (IBM A31p), with an Intel 845 Brookdale chipset
> and SpeedStep support.

The same here, but it worked in 2.5.68. It's a P3 Speedstep. /proc/cpufreq 
only shows the header.


$ cat /sys/class/cpu/cpu0/device/name
CPU 0
$ cat /sys/class/cpu/cpu0/device/power
0


-- 
  ricardo galli       GPG id C8114D34
