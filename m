Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277383AbRJEOL1>; Fri, 5 Oct 2001 10:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277386AbRJEOLR>; Fri, 5 Oct 2001 10:11:17 -0400
Received: from [205.176.221.61] ([205.176.221.61]:2834 "EHLO w20303512")
	by vger.kernel.org with ESMTP id <S277383AbRJEOK6>;
	Fri, 5 Oct 2001 10:10:58 -0400
Message-ID: <018401c14da7$bc2568d0$3dddb0cd@w20303512>
From: "Wilson" <defiler@null.net>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0110032019480.12116-100000@dozer.dreamhost.com> <E15oxYi-00015G-00@schizo.psychosis.com> <01100422312200.01464@homer> <E15pVCy-0006zo-00@schizo.psychosis.com>
Subject: Re: [POT] Linux SAN?
Date: Fri, 5 Oct 2001 10:12:13 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> On Thursday 04 October 2001 22:31, someone wrote:
>
> > For the HBA ( fibre channel adapter ) i use the module in the kernel
CPQFC
> > is for a specific compaq HBA, but you can use use QLOGIC module or
EMULEX (
> > but the EMULEX driver is not under GPL and you don't have source and
it's
> > really convinient for the correction on the driver ) with support for
FC.
>

Is anyone aware of a project (now that LinuxDisk is gone..) that has the
potential to turn a Linux box into one of these?
I'd like to have a Linux machine running as a "SAN appliance" with a
heterogenous mix of servers (with FC cards) booting from "virtual" slices of
one big array.
I'm envisioning a "roll your own" version of this Winchester Flaskdisk
product:
http://www.winsys.com/products/

Regards,
--Wilson.


