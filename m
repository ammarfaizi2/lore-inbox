Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbQLSAM2>; Mon, 18 Dec 2000 19:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129507AbQLSAMS>; Mon, 18 Dec 2000 19:12:18 -0500
Received: from c984966-a.chmpgn1.il.home.com ([24.22.18.225]:64008 "EHLO
	draco.mcnabbs.org") by vger.kernel.org with ESMTP
	id <S129431AbQLSAMI>; Mon, 18 Dec 2000 19:12:08 -0500
Date: Mon, 18 Dec 2000 17:41:41 -0600 (CST)
From: Andrew McNabb <amcnabb@mcnabbs.org>
To: David Feuer <David_Feuer@brown.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: APM/DPMS lockup on Dell 3800
In-Reply-To: <3A3D9F7A.40F1004@brown.edu>
Message-ID: <Pine.LNX.4.21.0012181740390.28635-100000@draco.mcnabbs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a problem with the 3Com Ethernet card in your system.
There are annoying problems when you try to use this card on
a network with a lot of collisions.


On Mon, 18 Dec 2000, David Feuer wrote:

> BTW, what does it mean when this gets logged?
> 
> Dec 17 19:01:09 localhost kernel: eth0: Resetting the Tx ring pointer.
> Dec 17 19:01:09 localhost kernel: eth0: Tx Ring full, refusing to send
> buffer.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 


--
Andrew McNabb
amcnabb@mcnabbs.org
http://www.mcnabbs.org/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
