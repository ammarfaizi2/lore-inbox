Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265177AbSKRWJN>; Mon, 18 Nov 2002 17:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265180AbSKRWJN>; Mon, 18 Nov 2002 17:09:13 -0500
Received: from windsormachine.com ([206.48.122.28]:48396 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S265177AbSKRWJK>; Mon, 18 Nov 2002 17:09:10 -0500
Date: Mon, 18 Nov 2002 17:16:09 -0500 (EST)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RTL8139D support for 2.4?
In-Reply-To: <3DD965EE.5010008@pobox.com>
Message-ID: <Pine.LNX.4.33.0211181714340.1796-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Jeff Garzik wrote:

> Given the output you just provided, 8139too is indeed the only driver
> that will work for you.
>
> WRT pci-skeleton.c I think that is a red herring for you... 8139cp
> support is available from 8139cp.c.  But given the lspci output, it will
> not work for you...
>
> thanks!
>
> 	Jeff

I guess 2.4.20 should get the proper pci_id added into 8139too.c then, if
these cards are just starting to come out.

I left the D card in my workstation for now, I'll see how it handles the
nightly backup tonight, and if you want me to test things for 8139cp

What IS pci-skeleton then?

Mike

