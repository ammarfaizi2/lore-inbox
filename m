Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132796AbRAaUzx>; Wed, 31 Jan 2001 15:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132797AbRAaUzn>; Wed, 31 Jan 2001 15:55:43 -0500
Received: from anime.net ([63.172.78.150]:39943 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S132796AbRAaUze>;
	Wed, 31 Jan 2001 15:55:34 -0500
Date: Wed, 31 Jan 2001 12:55:04 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Andre Hedrick <andre@linux-ide.org>
cc: Mark Lord <mlord@pobox.com>,
        Rupa Schomaker <rupa-list+linux-kernel@rupa.com>,
        <Andries.Brouwer@cwi.nl>, <ole@linpro.no>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Problems with Promise IDE controller under 2.4.1
In-Reply-To: <Pine.LNX.4.10.10101311207090.13759-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.30.0101311254350.19040-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Andre Hedrick wrote:
> On Wed, 31 Jan 2001, Mark Lord wrote:
> > Even better would be to add a stage in front of the fall-back,
> > which queries the BIOS (from kernel startup code) for translation
> > info on ALL drives.
> Maybe a compile option could help...

kernel parameter passed via lilo...

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
