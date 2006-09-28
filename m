Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031311AbWI1AyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031311AbWI1AyX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 20:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031312AbWI1AyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 20:54:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:30468 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1031311AbWI1AyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 20:54:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l3vjrw+e1J/emnowCZeaSZVlaAEUB/fjNYJ6Ucxu353jc266td2+etZY5r4O1hyXJEWgnBTAc/C6cYdMLdUSPHxeZWny5gDKi6CzkgySfBGW8rSHDf62er0wy1X2U1dG6MqtKsDnvsPwKmKNVFwJjs4ocBKaTVHLa/o/HCIcV3Y=
Message-ID: <d577e5690609271754u395e56ffr1601fddd6d4639a3@mail.gmail.com>
Date: Wed, 27 Sep 2006 20:54:19 -0400
From: "Patrick McFarland" <diablod3@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: GPLv3 Position Statement
Cc: "Chase Venters" <chase.venters@clientec.com>,
       "Theodore Tso" <tytso@mit.edu>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "Sergey Panov" <sipan@sipan.org>,
       "James Bottomley" <James.Bottomley@steeleye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0609271641370.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
	 <Pine.LNX.4.61.0609270753590.19275@yvahk01.tjqt.qr>
	 <1159342569.2653.30.camel@sipan.sipan.org>
	 <Pine.LNX.4.61.0609271051550.19438@yvahk01.tjqt.qr>
	 <1159359540.11049.347.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0609271000510.3952@g5.osdl.org>
	 <Pine.LNX.4.64.0609271300130.7316@turbotaz.ourhouse>
	 <20060927225815.GB7469@thunk.org>
	 <Pine.LNX.4.64.0609271808041.7316@turbotaz.ourhouse>
	 <Pine.LNX.4.64.0609271641370.3952@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 September 2006 20:18, Linus Torvalds wrote:
> I think a lot of people may be confused because what they see is
>
>  (a) Something that has been brewing for a _loong_ time. There has been
>      the FSF position, and there has been the open source position, and
>      the two have been very clearly separated.

But whats wrong with that? The FSF is a "project" (or really, a group
of projects, because some FSF projects don't agree with the FSF
position either), it isn't them official voice of the community.

The open source community (which, of course, the FSF hates the term
"open source" because it undermines their authority) is made up of
many projects, each with their own official line. RMS has his, you
have yours, GNOME has theirs, KDE has theirs, and so on.

>      At the same time, both camps have been trying to be somewhat polite,
>      as long as the fact that the split does clearly exist doesn't
>      actually _matter_.

I agree. It doesn't matter because everyone is free to use whatever
version they want of the GPL. Of course, people do also recognize that
the GPL2 vs GPL3 argument is just a more subtle version of whats been
going on for years with BSD vs GPL.

>      So, for example, the GPLv2 has been acceptable to all parties (which
>      is what I argue is its great strength), and practically you've not
>      actually had to care. In fact, most programmers _still_ probably
>      don't care. A lot of people use a license not because they "chose"
>      it, but because they work on a project where somebody else chose the
>      license for them originally.

Programmers don't care because we aren't lawyers. I mean, few things
are stated so simply, but lets face it, law is boring to quite a few
geeks, and the intersection between geeks who code and geeks who law
is very small.

>  (b) This tension and the standpoints of the two sides has definitely
>      _not_ been unknown to the people involved. Trust me, the FSF knew
>      very well that the kernel standpoint on the GPLv2 was that Tivo was
>      legally in the right, and that it was all ok in that sense.
>
>      Now, a number of people didn't necessarily _like_ what Tivo does or
>      how they did it, but the whole rabid "this must be stopped" thing was
>      from the FSF side.

Which is why I said above, the FSF is not the official voice of the
community, but instead one of many, and also no longer one of the
loudest.

> > What I was really addressing here is that the whole F/OSS community
> > exploded over the news that Linux was not adopting the GPLv3.
>
> Not really. It wasn't even news. The kernel has had the "v2 only" thing
> explicitly for more than half a decade, and I have personally tried to
> make it very clear that even before that, it never had anything else (ie
> it very much _had_ a specific license version, just by including the damn
> thing, and the kernel has _never_ had the "v2 or any later" language).

Wasn't that just to prevent the FSF from going evil and juping all your code?

> In fact, a lot of people have felt that they've been riding of the
> coat-tails of Linux - without ever realizing that one of the things that
> made Linux and Open Source so successful was exactly the fact that we did
> _not_ buy into the rhetoric and the extremism.

The only problem is that, alternatively, the FOSS movement was so
strong because of RMS's kool-aid everyone drank. The community has
teeth, and this is in partly because of the actions of the FSF. We
defend ourselves when we need to.

Its just that, at least with the Tivo case, that the defense went a tad too far.

> Claiming that the FSF didn't know, and that this took them "by surprise"
> is just ludicrous. Richard Stallman has very vocally complained about the
> Open Source people having "forgotten" what was important, and has talked
> about me as if I'm some half-wit who doesn't understand the "real" issue.

The real issue, in my opinion, is that RMS found out that he no longer
leads the community, and his power base is a lot smaller than it used
to be. The FSF itself is a lot less relevant than it was 10 years ago.

> In fact, they still do that. Trying to explain the "mis-understanding".

Ego does wonders.

> Because the even _deeper_ rift between the FSF and the whole "Open Source"
> community is not over "Tivo" or any particular detail like that, but
> between "practical and useful" and "ideology".

I agree. I totally agree. The rift exists _not_ because the OSS
community wants to do its own thing, but because the FSF are no longer
the overlords of the Bazaar that they thought they were.

> 			Linus

Also, I expect to get flamed for what I've written above, especially
from RMS in some form or another. Thats fine. The FSF has given the
community a lot, and us, the community, has given a lot in return.

That doesn't, however, give RMS the right to be some sort of King. The
OSS community, instead, is a form of a democracy, and you vote with
your code.

Linus, you voted with your code.

-- 
Patrick McFarland || http://AdTerrasPerAspera.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids,
we'd all be running around in darkened rooms, munching magic pills and
listening to repetitive electronic music." -- Kristian Wilson, Nintendo,
Inc, 1989
