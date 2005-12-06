Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932614AbVLFSd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbVLFSd4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbVLFSd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:33:56 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:60662 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932614AbVLFSdz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:33:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p+he8xJPN0/iXa1FxeLY1I+E6SbCiA8c7anVWdx3JU4oqOvAj/SrdUcGoocQ1QtfvnKeA+2Oxa3dJZpc7dputpj5WAbh8UudPn0mtd4+86ywbuWyaZE3OvTQdW+6JIZeWSNYXMPljUh95o7GFM3+inj2dFCqGpN2egIBNExN0Q0=
Message-ID: <9a8748490512061033y79692c98xb49b6ab63e103502@mail.gmail.com>
Date: Tue, 6 Dec 2005 19:33:54 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: Linux in a binary world... a doomsday scenario
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0512051954040.19959@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <4394D396.1020102@am.sony.com>
	 <21d7e9970512051610n1244467am12adc8373c1a4473@mail.gmail.com>
	 <200512052122.02485.gene.heskett@verizon.net>
	 <Pine.LNX.4.64.0512051954040.19959@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/05, Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
> On Mon, 5 Dec 2005, Gene Heskett wrote:
>
> > Which is the best reason in the world to buy and use, the open source
> > video card now under development, and I hear its less than 3-4 months
> > from production status now, and at a competitive, sub $150 USD price.
> >
> > If 50% of nvidia's currant linux market share were to dissappear a month
> > after this card becomes available for purchase by those whom one might
> > categorize as believers, I'd think that would send a message loud enough
> > to be heard.
> >
> > Particularly if windows drivers are available, open sourced, and
> > installable on a winderz box using the normal install wizard, and
> > promoted as such to the joe six-packs of the world.  At the right price,
> > that would send an even louder message to both nvidia and ati
>
> Do you think this opensource hardware could keep up with nvidia and ati
> hardware development? Joe sixpack is all about the fastest hardware.

Well, they are not aiming at creating a high end gaming card.

Here are some quotes from various documents at http://www.opengraphics.org/  :

"
Requirements

In order to be interesting to the open source community and OEM
vendors such a card should at a minimum meet the following
requirements:

    * Programming interface must be fully documented
    * No IP encumberment for implementing drivers
    * Very good 2d graphics performance
    * Full OpenGL implementation with as much hardware acceleration as possible
    * Good support for xv (yuv->rgb, scaling) for video playback
    * Reasonable price!
"

"
Due to market size it will not be possible to compete on 3d
performance with market leaders such as ATI and NVIDIA. This is not an
immediate problem because gaming is not what this card is aimed at,
but performance should be good enough for scientific simulations and
similar.
"

"
   1.  *Will I be able to play Doom 3 with this hardware?*

Nope, but at the time of this writing, there is no graphics card on
the market on which you can play Doom 3 well while using open source
drivers. Less demanding games are likely to work however.
"

"
With about 6.4 gigabytes/second memory bandwidth, the video
performance should be comparable to current midrange graphic-cards
like the ATI Radeon 9600 which can e.g. play Battlefield 2.
"

Their featurelist also has more details:
http://wiki.duskglow.com/tiki-index.php?page=FeatureList


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
