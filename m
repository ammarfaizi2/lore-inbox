Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbUANT5M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265200AbUANT4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:56:37 -0500
Received: from palrel11.hp.com ([156.153.255.246]:40410 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S264971AbUANT4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:56:18 -0500
Date: Wed, 14 Jan 2004 11:56:16 -0800
To: Jens David <dg1kjd@afthd.tu-darmstadt.de>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       davem@redhat.com, jgarzik@pobox.com
Subject: Re: [SPAM?] [PATCH] Backport via-ircc to Linux-2.4 from 2.6
Message-ID: <20040114195616.GB21754@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040114002920.GA13260@bougret.hpl.hp.com> <200401140817.i0E8HBw27502@dl0td.afthd.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401140817.i0E8HBw27502@dl0td.afthd.tu-darmstadt.de>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 09:17:11AM +0100, Jens David wrote:
> Hi,
> 
> look, I do not have much time for this political discussion.
> All I say is:
> 
> - I backported the VIA FIR IRDA driver from 2.6 because I needed it
> - Most other AMD-based laptop users will need it too
> - The driver (or at least a close relative) worked flawlessly for me for 1 year
> - The backport does not affect other drivers or system stability even when loaded
> - I am willing to maintain it till 2.4 is phased out. Which is the case when
>   distros decide to go 2.6, but no earlier.
> 
> Here is the patch, take it or leave it or start talking CODE.
> 
>   -- j

	Wow, whose code are we talking about ? Just for your
information (and Jeff will confirm), it was possible to integrate the
VIA driver in the kernel only because I fixed many integration issues,
(VIA was mostly unresponsive), and I don't have this hardware.
	I told you the problem was the lack of testing. Now that you
solved this issue, things will go forward. But, I'm only human.

	Jean
