Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130753AbRBGVDY>; Wed, 7 Feb 2001 16:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130777AbRBGVDQ>; Wed, 7 Feb 2001 16:03:16 -0500
Received: from nilpferd.fachschaften.tu-muenchen.de ([129.187.176.79]:47318
	"HELO nilpferd.fachschaften.tu-muenchen.de") by vger.kernel.org
	with SMTP id <S130753AbRBGVDH>; Wed, 7 Feb 2001 16:03:07 -0500
Date: Wed, 7 Feb 2001 22:03:07 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: <bunk@gaia.fachschaften.tu-muenchen.de>
To: Matthias Schniedermeyer <ms@citd.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@caldera.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.1-ac5
In-Reply-To: <20010207215423.A17404@citd.de>
Message-ID: <Pine.NEB.4.33.0102072201590.23491-100000@gaia.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Feb 2001, Matthias Schniedermeyer wrote:

> > > now that -ac grows that huge, could you put out incremental patches?
> >
> > Takes me too much time. But if anyone else wants to, go ahead
>
> This is what i use to diff 2 different kernels
>
> - snip -
>...
> - snip -
>
> This takes about 8 seconds (for 2.4 kernels) on my Dual PIII-933, 1Gig-RAM

Or you take the two patches and use interdiff [1].

> Bis denn

cu,
Adrian

[1] http://people.redhat.com/twaugh/ftp/interdiff/stable/


-- 
A "No" uttered from deepest conviction is better and greater than a
"Yes" merely uttered to please, or what is worse, to avoid trouble.
                -- Mahatma Ghandi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
