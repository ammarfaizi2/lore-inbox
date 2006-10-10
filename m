Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWJJQjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWJJQjN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 12:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWJJQjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 12:39:13 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:22747 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932213AbWJJQjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 12:39:11 -0400
From: Christian <christiand59@web.de>
To: "Langsdorf, Mark" <mark.langsdorf@amd.com>
Subject: Re: cpufreq not working on AMD K8 (was Re: 2.6.19-rc1: known regressions)
Date: Tue, 10 Oct 2006 18:37:10 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <1449F58C868D8D4E9C72945771150BDF1536ED@SAUSEXMB1.amd.com>
In-Reply-To: <1449F58C868D8D4E9C72945771150BDF1536ED@SAUSEXMB1.amd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610101837.10292.christiand59@web.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:176b6e6b41629db5898eee8167b5e3a0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 10. Oktober 2006 16:59 schrieb Langsdorf, Mark:
> > I have an AMD K8 system and I'm unable to get cpufreq working
> > with 2.6.19-rc1.
> > The cpufreq sysfs directory is missing under
> > /sys/devices/system/cpu/cpu0/.
> > 2.6.18 works as expected.
>
> What error message are you getting from `dmesg | grep power` ?

dmesg | grep power
[   17.852383] powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 
3800+ processors (version 2.00.00)
[   17.852403] powernow-k8: MP systems not supported by PSB BIOS structure
[   17.852428] powernow-k8: MP systems not supported by PSB BIOS structure

Haven't seen this before.

-Christian

