Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131718AbQLMVLs>; Wed, 13 Dec 2000 16:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131953AbQLMVLi>; Wed, 13 Dec 2000 16:11:38 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:3859 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131718AbQLMVLT>; Wed, 13 Dec 2000 16:11:19 -0500
Date: Wed, 13 Dec 2000 14:36:28 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Mike Galbraith <mikeg@wen-online.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Signal 11 - the continuing saga
Message-ID: <20001213143628.A16301@vger.timpanogas.org>
In-Reply-To: <Pine.Linu.4.10.10012131856130.448-100000@mikeg.weiden.de> <Pine.LNX.4.10.10012131131090.19837-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.10.10012131131090.19837-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Dec 13, 2000 at 11:35:57AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2000 at 11:35:57AM -0800, Linus Torvalds wrote:
> 
> 
> Ehh, I think I found it.
> 
> Hint: "ptep_mkdirty()".
> 
> Oops.
> 
> I'll bet you $5 USD (and these days, that's about a gadzillion Euros) that
> this explains it.
> 
> 		Linus

Good.  Sounds like you guys have a handle on it now.

:-)

Jeff

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
