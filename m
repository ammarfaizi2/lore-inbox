Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130687AbQLFUa4>; Wed, 6 Dec 2000 15:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130791AbQLFUap>; Wed, 6 Dec 2000 15:30:45 -0500
Received: from anime.net ([63.172.78.150]:49161 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S130687AbQLFUad>;
	Wed, 6 Dec 2000 15:30:33 -0500
Date: Wed, 6 Dec 2000 12:00:41 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
cc: Skip Collins <bernard.collins@jhuapl.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: system hang and corrupt ext2 filesystem with test12-pre5
In-Reply-To: <3A2E5FAA.FF29E9D7@Hell.WH8.TU-Dresden.De>
Message-ID: <Pine.LNX.4.30.0012061200060.23141-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2000, Udo A. Steinberg wrote:
> What drive are you using? AFAIR, Andre Hedrick once said certain Maxtor
> drives aren't quite safe with DMA.

Depends on the controller. Maxtor drives play badly with Highpoint
controllers, but are OK with Promise.

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
