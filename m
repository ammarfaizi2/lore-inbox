Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLRUs1>; Mon, 18 Dec 2000 15:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129477AbQLRUsG>; Mon, 18 Dec 2000 15:48:06 -0500
Received: from virtualro.ic.ro ([194.102.78.138]:22540 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S129319AbQLRUr4>;
	Mon, 18 Dec 2000 15:47:56 -0500
Date: Mon, 18 Dec 2000 22:17:17 +0200 (EET)
From: Jani Monoses <jani@virtualro.ic.ro>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0test13pre3ac1
In-Reply-To: <E14868l-00064b-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10012182211040.15640-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Dec 2000, Alan Cox wrote:

> o	Teach kernel-doc about const			(Jani Monoses)

Tim Waugh pointed out this wasn't good as 'const' is part of the function
signature and he now has a better patch.

> o	Add documentation to the PCI api		(Jani Monoses)
> o	Fix inode.c documentation			(Jani Monoses)

For these I've sent Tim more cleaned up patches as I thought nobody picked
them up from the list.Looks like I was wrong ;-)

Jani.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
