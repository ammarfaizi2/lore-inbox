Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276285AbRJUPg6>; Sun, 21 Oct 2001 11:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276302AbRJUPgv>; Sun, 21 Oct 2001 11:36:51 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58384 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276285AbRJUPgg>; Sun, 21 Oct 2001 11:36:36 -0400
Subject: Re: Promise SuperTrak 100/SX6000 support?
To: nneul@umr.edu (Neulinger, Nathan)
Date: Sun, 21 Oct 2001 16:43:01 +0100 (BST)
Cc: linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <6CAC36C3427CEB45A4A6DF0FBDABA56D86D92A@umr-mail03.cc.umr.edu> from "Neulinger, Nathan" at Oct 18, 2001 01:49:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vKkf-0006o5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I asw discussions on the list back in April talking about Alan and some
> others working on driver support for this card (i.e. open-source drivers,
> not the binary-only stuff the promise distributes), but haven't seen any
> mention since.
> 
> What's the status? Is there functional support in the works or is this a
> long ways off?

The Supertrak100 works in both the Linus and -ac tree. The latest Supertrak
works in the -ac tree only.

They are i2o_block interfaces
