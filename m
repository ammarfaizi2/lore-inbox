Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281124AbRKOWET>; Thu, 15 Nov 2001 17:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281129AbRKOWEJ>; Thu, 15 Nov 2001 17:04:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61968 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281125AbRKOWD6>; Thu, 15 Nov 2001 17:03:58 -0500
Subject: Re: Problem with 2.4.14 mounting i2o device as root device Adapte
To: Deanna_Bonds@adaptec.com (Bonds, Deanna)
Date: Thu, 15 Nov 2001 22:09:36 +0000 (GMT)
Cc: michael@wizard.ca ('Michael Peddemors'), linux-kernel@vger.kernel.org
In-Reply-To: <F4C5F64C4EBBD51198AD009027D61DB31C8265@otcexc01.otc.adaptec.com> from "Bonds, Deanna" at Nov 15, 2001 04:55:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E164UhU-0001qs-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a RedHat issue.  You can find some info on
> http://people.redhat.com/tcallawa/dpt/ .  We will have the official drivers

Its in the base kernel too. I've sent Linus all the pending i2o updates
for 2.4.15 however, which should mean that all the DPT cards are skipped
(at least the ones I have pci idents for). Its possible the 3200 isnt in
that list.

Alan
