Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275680AbRJJNEo>; Wed, 10 Oct 2001 09:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275687AbRJJNEe>; Wed, 10 Oct 2001 09:04:34 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33029 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275680AbRJJNEY>; Wed, 10 Oct 2001 09:04:24 -0400
Subject: Re: Tainted Modules Help Notices
To: sirmorcant@morcant.org (Morgan Collins [Ax0n])
Date: Wed, 10 Oct 2001 14:10:26 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <32879.24.255.76.12.1002701163.squirrel@webmail.morcant.org> from "Morgan Collins [Ax0n]" at Oct 10, 2001 01:06:03 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15rJ7y-0007kO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     What surprised me was the PPP compression modules, I didn't use PPP in 2.4.10 so maybe
> the notice was there in 2.4.10, but I didn't use them so I didn't see it. I shouldn't have
> been surprised, but I was. BSD compression, BSD license... doh... :>

Some of these are just things we need to tidy

>     After this discovery, I would like to ask opinions on including licensing terms in
> item/module help files. It would be very convient if under dpt_i2o help it said that it
> was licensed under BSD-NAC.

The kernel dpt_i2o is GPL. Its in part built from GPL'd code I wrote but
mostly from what I assume was originally a  cross platform dpt source set.

Alan
