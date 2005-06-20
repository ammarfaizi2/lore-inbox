Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVFTR2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVFTR2c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 13:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVFTR2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 13:28:32 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:33484
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261398AbVFTR2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 13:28:25 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: <linux-thinkpad@linux-thinkpad.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [ltp] Re: IBM HDAPS Someone interested?
Date: Mon, 20 Jun 2005 11:28:16 -0600
Message-ID: <005b01c575bd$724fac60$600cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <42B6F6F6.2040704@zipman.it>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> > Well, some piece of software needs to park the HDD when the
> notebook is
> > falling, and that piece of software should better be
> running since the
> > notebook is powered on. Hence my suspicion it's in the
> BIOS. It doesn't
> > have to be visible to the user, at all.
>
> No, the software, under Windows, is an application; you can control
> the behaviour of the disk based on the response of the chip.
>
> Anyway I don't think it's a simple task to create a driver for the
> accelerometer; one thing is to read the data from the chip (I suppose
> it's not too hard), but the most part of the job is to know what to do
> with the data you read.
>
> IBM developed a mathematical model that describes the typical usage of
> the ThinkPad, and they based the action on this math model. Developing
> a free math model is quite hard and also we cannot destroy 5 or 6 TP
> only to see how the signals are produced by the chip in all the
> possible situations (IBM instead can destroy as much TP as
> they want :(
>
> I think the only practical solution is to ask IBM to release a free
> driver for linux; maybe joining our forces we can achive some result.
>
> - --
> Flavio Visentin

What is normally done here in Linux? A mass of people starts sending emails
to IBM to ask for ANY support, or do we have contacts? I have already
contacted the Linux developers that created the Linux driver for the
security chip for the IBM's and they had no clue of what they can do?

If this is the case, and there is no normal way for IBM to release the spec
or driver, then we will need to send emails to IBM, asking for the Linux
support. After all, they claim that they are all into Linux (not all, but
they kind of like it)

What should we do? askibm@info.ibm.com ? Should we go into the Query page
and ask them there? https://www.ibm.com/contact/us/en/query

Lenovo has the PC stuff of IBM, but still, they are fully into it and
therefore will be able to know what they can do here. The support is given
by IBM, not lenovo, they just sell the computers.

????

.Alejandro

