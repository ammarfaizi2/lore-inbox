Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262283AbSJGB1M>; Sun, 6 Oct 2002 21:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262302AbSJGB1M>; Sun, 6 Oct 2002 21:27:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19471 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262283AbSJGB1L>; Sun, 6 Oct 2002 21:27:11 -0400
Date: Sun, 6 Oct 2002 18:34:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: [PATCH] Bluetooth kbuild fix and config cleanup
In-Reply-To: <1033954016.909.10.camel@pegasus>
Message-ID: <Pine.LNX.4.44.0210061834080.21788-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 7 Oct 2002, Marcel Holtmann wrote:
> 
> I will change this and submit you a new patch. Should I do this also for
> only one conditional like in net/bluetooth/rfcomm/Makefile? So it will
> look like this:

Yes please, that looks right.

		Linus

