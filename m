Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129187AbQKOPsv>; Wed, 15 Nov 2000 10:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129788AbQKOPsl>; Wed, 15 Nov 2000 10:48:41 -0500
Received: from 213-1-124-214.btconnect.com ([213.1.124.214]:26498 "EHLO
	saturn.homenet") by vger.kernel.org with ESMTP id <S129187AbQKOPs1>;
	Wed, 15 Nov 2000 10:48:27 -0500
Date: Wed, 15 Nov 2000 15:20:21 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Fabrice Peix <Fabrice.Peix@sophia.inria.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: Microcode ....
In-Reply-To: <3A12A750.F87F9DFB@sophia.inria.fr>
Message-ID: <Pine.LNX.4.21.0011151518100.1567-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2000, Fabrice Peix wrote:

> 
> 
> 	Yop,
> 	Just a newbie question :
> 	What do exactly Intel P6 Microcode.

it is applied to fix bugs, usually. No, there is no description which
exactly bugs are fixed by which revision of the microcode so what you do
is to always apply the latest, available on:

http://www.urbanmyth.org/microcode/

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
