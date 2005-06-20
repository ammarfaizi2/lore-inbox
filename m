Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVFTRRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVFTRRq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 13:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVFTRRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 13:17:46 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:17097
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261368AbVFTRRn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 13:17:43 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: "'Lenz Grimmer'" <lenz@grimmer.com>, <linux-thinkpad@linux-thinkpad.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [ltp] Re: IBM HDAPS Someone interested?
Date: Mon, 20 Jun 2005 11:17:37 -0600
Message-ID: <005a01c575bb$f51efcb0$600cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <42B6F723.50808@grimmer.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I tried monitoring the output of the embedded controller register dump
> that the "ibm-acpi" kernel module provides, using the
> following command
> and then moving the Laptop (Thinkpad T42) to trigger changes:
>
>   watch -n1 cat /proc/acpi/ibm/ecdump
>
> Alas, there wasn't really a pattern that convinced me that the chip
> actually is monitored via this controller. But of course it
> may not harm
> if somebody else double checks this.
>
> > Well, some piece of software needs to park the HDD when the notebook
> > is falling, and that piece of software should better be
> running since
> > the notebook is powered on. Hence my suspicion it's in the BIOS. It
> > doesn't have to be visible to the user, at all.
>
> On Windows, you need to run a separate tray application that
> enables the
> protection. So it seems like it's implemented in "userspace".
> It may be
> worth debugging what this Window applet actually does...
>
> Bye,
> 	LenZ

Lenz,

	I will try this at home in about 4 hours and then let you know of the
output. This is really the first command that I can see that might give us
any/non information.

.Alejandro

