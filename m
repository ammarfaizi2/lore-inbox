Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423336AbWJZSAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423336AbWJZSAG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 14:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161395AbWJZSAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 14:00:03 -0400
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:9673 "EHLO
	aa011msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1161387AbWJZSAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 14:00:01 -0400
Message-ID: <001201c6f928$89c9a720$2b20ff27@flaviopc>
From: "Inter filmati" <interfc@jumpy.it>
To: <linux-kernel@vger.kernel.org>
References: <001501c6f921$56c3fe40$2b20ff27@flaviopc> <20061026174153.GB18076@amd64.of.nowhere>
Subject: Re: cpufreq/powernowd limiting CPU frequency on kernels >=2.6.16
Date: Thu, 26 Oct 2006 19:59:41 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Antivirus: avast! (VPS 0643-5, 26/10/2006), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: <thunder7@xs4all.nl>
To: "Inter filmati" <interfc@jumpy.it>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, October 26, 2006 7:41 PM
Subject: Re: cpufreq/powernowd limiting CPU frequency on kernels >=2.6.16

> Which means that my X2 4600+ works just fine, but after overclocking
> cpufreq restores it to the FSB that it should run on.
>
> If you care about that changed, try to find out what patch caused this,
> but in general, there's no support for overclocking in the kernel, and
> bugreports from overclocked systems are frowned upon.
>
It would be kind to find out why the problem seems to show only from 2.6.16 
and not before, unfortunately I ain't so skilled to investigate into cpufreq 
source.

---
Flavio
www.flapane.com 

