Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264256AbUD0SCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUD0SCx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 14:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264247AbUD0SCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 14:02:52 -0400
Received: from smtp-out4.xs4all.nl ([194.109.24.5]:55558 "EHLO
	smtp-out4.xs4all.nl") by vger.kernel.org with ESMTP id S264256AbUD0SBZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 14:01:25 -0400
Date: Tue, 27 Apr 2004 20:01:17 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: Christoph Pohl <christoph.pohl@inf.tu-dresden.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Low bogomips on IBM x445 (kernel 2.6.5)
Message-ID: <20040427180117.GA2150@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <408E3D74.2090301@inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408E3D74.2090301@inf.tu-dresden.de>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Pohl <christoph.pohl@inf.tu-dresden.de>
Date: Tue, Apr 27, 2004 at 01:01:08PM +0200
> Hello,
> 
> I'm currently configuring an IBM x445 box with 4 Xeon CPUs (3GHz) and 
> hyperthreading enabled. Everything seems to work fine since kernel 2.6.5 
> but I keep wondering about the *very low* Bogomips numbers. Here is what 
> I see in /proc/cpuinfo:
> 
What does 

cat /proc/mtrr

say and how much memory is in that thing?

Jurriaan
-- 
Is it a son? Is it a daughter? It's an Addams!
        Addams Family II
Debian (Unstable) GNU/Linux 2.6.6-rc2-mm2 2x6062 bogomips 2.58 1.39
