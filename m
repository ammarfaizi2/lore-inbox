Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265181AbTLaP6a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 10:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265182AbTLaP6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 10:58:30 -0500
Received: from nat-ph3-wh.rz.uni-karlsruhe.de ([129.13.73.33]:22156 "EHLO
	au.hadiko.de") by vger.kernel.org with ESMTP id S265181AbTLaP61
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 10:58:27 -0500
From: Jens =?iso-8859-1?q?K=FCbler?= <cleanerx@au.hadiko.de>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: nForce2 keeps crashing during network activity
Date: Wed, 31 Dec 2003 16:58:29 +0100
User-Agent: KMail/1.5.3
References: <200312221451.06331.ross@datscreative.com.au> <200312222341.32367.ross@datscreative.com.au>
In-Reply-To: <200312222341.32367.ross@datscreative.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312311658.29569.cleanerx@au.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Might be a mandrake source thing, not liking nforce2 perhaps?
>
> If you don't mind a bit of work, you could download current standard 2.4.23
> kern source, add my patches, compile with acpi and uniprocessor ioapic,
> Athlon etc. use the onboard nic, and try it with apic_tack=1 kernel arg.
>
> Regards
> Ross.

Transfered 1,8 GB without any crash. As the nvnet module seems to be part of 
the NVIDIA released drivers I use my Realtek 8139 (like before when I had the 
crashes). I just compiled the NVIDIA drivers and will give it a run. I am 
wondering where the actual bug might be located as you remember that I did 
not use APIC in the first place.

Thanx for help

Jens

