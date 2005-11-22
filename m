Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965047AbVKVVRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbVKVVRR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbVKVVQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:16:52 -0500
Received: from palrel13.hp.com ([156.153.255.238]:40883 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S965038AbVKVVQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:16:50 -0500
Date: Tue, 22 Nov 2005 13:14:26 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jani Monoses <jani.monoses@gmail.com>
Subject: Re: BUG 2.6.14.2 : ACPI boot lockup
Message-ID: <20051122211426.GA29576@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jani Monoses wrote :
> 
> Same here, sent a similar mail yesterday to lkml, Subj: softlockup with
> 2.6.12.

	When I searched ACPI on LKML, I was swamped with results. The
URL of your e-mail, by the way :
	http://marc.theaimsgroup.com/?l=linux-kernel&m=113258621423823&w=2
	By the way, I've got nearly the same laptop, maybe I'll check
for BIOS updates.

> I just did not capture the backtrace.

	I use serial console, which make it trivial. Yeah, all my
laptops still have a serial port.
	On the other hand, you narrowed the GIT commit which caused
troubles, so that's progress.

> Jani

	Thanks...

	Jean
