Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262312AbSKTT6G>; Wed, 20 Nov 2002 14:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262314AbSKTT6G>; Wed, 20 Nov 2002 14:58:06 -0500
Received: from relay.snowman.net ([66.92.156.198]:15886 "EHLO
	relay.snowman.net") by vger.kernel.org with ESMTP
	id <S262312AbSKTT6C> convert rfc822-to-8bit; Wed, 20 Nov 2002 14:58:02 -0500
From: nick@snowman.net
Date: Wed, 20 Nov 2002 14:16:49 -0500 (EST)
To: Andre Hedrick <andre@linux-ide.org>
cc: Dana Lacoste <dana.lacoste@peregrine.com>,
       Thomas =?ISO-8859-1?Q?Lang=E5s?= <tlan@stud.ntnu.no>,
       linux-kernel@vger.kernel.org
Subject: Re: spinlocks, the GPL, and binary-only modules
In-Reply-To: <Pine.LNX.4.10.10211201143030.3892-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.21.0211201415380.11473-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

7% of the code you're takeing from, or 7% of the code you're adding
to?  Either of these can be abused badly.  What do you
count?  Words?  Lines?  Uncommented lines?  Non-blank uncommented
lines?  I think it should and can be argued that the 7 second rule is
sound for code as well as music.
	Nick

On Wed, 20 Nov 2002, Andre Hedrick wrote:

> 
> How about 7% of code max that can pollute the headers and not taint the
> closed source.
> 
> 
> On Wed, 20 Nov 2002 nick@snowman.net wrote:
> 
> > Ahh, but that's 7 seconds of *PREFORMED* music.  This implies that no
> > matter how much past work has gone into it, if it can be run in under 7
> > seconds it can't be copyrighted.  I rather like this interpretation.
> > 	Nick
> > 
> > On 20 Nov 2002, Dana Lacoste wrote:
> > 
> > > On Wed, 2002-11-20 at 13:57, Thomas Langås wrote:
> > > > If someone snags 10-20 secs of a song,
> > > > and puts it into his/her song that's violation of the copyrights (given
> > > > that the person didn't ask for permission). But, then there's "what's the
> > > > minimum"-question
> > > 
> > > 7 seconds for music.
> > > 
> > > What's 7 seconds worth of code? :)
> > > 
> > > -- 
> > > Dana Lacoste
> > > Ottawa, Canada
> > > 
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 
> 

