Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269658AbSIRXim>; Wed, 18 Sep 2002 19:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269659AbSIRXim>; Wed, 18 Sep 2002 19:38:42 -0400
Received: from avscan1.sentex.ca ([199.212.134.11]:1802 "EHLO
	avscan1.sentex.ca") by vger.kernel.org with ESMTP
	id <S269658AbSIRXil>; Wed, 18 Sep 2002 19:38:41 -0400
Message-ID: <059501c25f6c$ec2a5860$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Patrick Mochel" <mochel@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209181558440.968-100000@cherise.pdx.osdl.net>
Subject: Re: linux-2.5.36 Oops on power-down
Date: Wed, 18 Sep 2002 19:41:34 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Patrick Mochel" <mochel@osdl.org>
> It appears that the 8250_pci serial driver needs a check for NULL when
> calling the device's re-init function. Could you try the attached patch
> and let us know if it works for you?

Patch Works For Me tm. Thanks.

..Stu


