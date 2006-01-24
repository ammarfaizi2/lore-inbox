Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbWAXDIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWAXDIx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 22:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbWAXDIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 22:08:53 -0500
Received: from smtpout.mac.com ([17.250.248.72]:43767 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1030305AbWAXDIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 22:08:52 -0500
In-Reply-To: <441e43c90601231755qaddb557r7f102d9c1f79ad5@mail.gmail.com>
References: <200601212043.k0LKhG4w003290@laptop11.inf.utfsm.cl> <Pine.LNX.4.61.0601231703170.13590@chaos.analogic.com> <87ek2y8n1f.fsf@basilikum.skogtun.org> <441e43c90601231755qaddb557r7f102d9c1f79ad5@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AE917BB1-E109-4880-AD11-1B22A3232A86@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: GPL V3 and Linux
Date: Mon, 23 Jan 2006 22:08:45 -0500
To: Ian Kester-Haney <ikesterhaney@gmail.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 23, 2006, at 20:55, Ian Kester-Haney wrote:
> Linux shouldn;t move to the GPL3 for the very reason that the DRM  
> restrictions would make linux incompatible with soon to be released  
> displays.

I'm sorry, what are you saying here?  I've not heard about these soon- 
to-be-released displays, could you elucidate, possibly summarizing or  
linking to references?

> Also Nvidia and such would not be able to make binary drivers  
> available.

In many peoples eyes, this would be a _good_ thing, besides, it's not  
clear whether or not their binary drivers are legal _now_, without  
concern for their status under the GPLv3

> Copyright for one work is set forward in law.  My view is that  
> Artists and their sponsors deserve the right to prevent piracy.

Have you tried describing music "piracy" to a small child (say, age  
6) in a way that distinguishes it from "sharing your things with  
other people"?  It's rather difficult, possibly even impossible.   
Many people argue that with modern technology, this distinction has  
become artificial and an artifact of an aging business model.  A  
number of artists who promote some music sharing have been doing very  
well.

> In my view the Open Source Community have an incompatible attitude.

I will ignore the second bit, since it's mostly a matter of opinion,  
but the Open Source Community (especially the Linux Community) values  
copyright extremely highly.  In fact, it is this copyright that makes  
the Linux Kernel sources a true democracy.  You cannot relicense the  
whole without agreement from all (or an extremely large majority  
bordering on "all") of the developers consent.

> In my mind the buying of a DVD means that I watch it on DVD players  
> be it on my computer or on the TV.

Or, according to Fair Use as set down in a number of court cases,  
make a single copy for backup, show privately to friends, convert to  
an alternative format for viewing in a different way or with other  
equipment.

> While I beleive that I should be able to watch my DVDs on a linux  
> based system, it behooves the open source community to support it  
> in a legal way.

I go to the store, I find a black box on the shelf, I pick it up, go  
to the cashier, pay for it, and leave the store.  At that point, I've  
purchased an object and may do whatever I like with said object.  I  
never signed any license or filled out any forms prior to paying  
money for it, and there was no condition that I do so, therefore no  
_license_ conditions apply.

On the other hand, copying the DVD and giving a copy to all your  
friends is _distributing_ it and therefore covered by _copyright_ law  
(not license/contract law), which makes it illegal for me to do so  
(although my personal opinion is that needs careful review and  
possible revision).

> Cracking Access Control Sytems might be fun, but it only generates  
> huge controversy in concerned industries.

<Biased Personal Opinion>
The industries do not matter.  The point of the government is to help  
and protect the _people_.  This means that to a limited extent, the  
government protects individuals copyrights, and allows corporations  
some rights (because they provide jobs, services, etc).  This does  
not mean that the government should do anything the industry wants  
even though hundreds of millions of people are breaking that law on a  
daily basis.  Something that widespread (especially given the lack of  
issues arising thereof) indicates that the _law_ is wrong, not the  
many millions doing the breaking.  This bends more towards the  
copyright issues I talk about above, but applies here too.
</Biased Personal Opinion>

Besides, a DRM system is pointless and futile; it's trying to protect  
data from people by giving them the encrypted data, the algorithm,  
and the key.  Any cryptographer will tell you that you are bound to  
lose from the start.

> An Open Source Access Control System that is respected by the FOSS  
> community would be a great diplomatic way to allow for more access  
> to content.

Open Source Access Control System:

if (access_allowed(media_descriptor, user_data)) {
	provide_data(media_descriptor);
}

My 3-line patch to "fix" it to let me watch my German DVD in the US:

--- oldfile
+++ newfile
-if (access_allowed(media_descriptor, user_data)) {
  	provide_data(media_descriptor);
-}

This is a _fundamentally_ _flawed_ idea.

> My personal view is that copying for my own personal use is ok

Good

> however the converting of such material in a way not granted to me  
> by the Creator is not ethical.

Why does the creator have any say in what you can do with it  
personally?  I'm legally allowed to buy a copy of MS Windows and burn  
it for symbolic value; why the hell would we want to allow a  
*CORPORATION* (Read: bunch of greedy rich executives) control what  
you can do with stuff.  Heck, we don't trust the _government_ (Read:  
bunch of greedy rich lawyers), or sometimes even one's personal  
_church_ to control.

> The GNU/Linux community needs to work with the MPAA, RIAA and other  
> DRM players and work to support basic restrictions on copying  
> content while preserving the Creator/Companies right to sustain  
> their works.

We don't _need_ to work with anybody, we're just converting abstract  
mathematical algorithms to a more practically useable form and  
publishing the result.  The fact that somebody with lawlessness in  
mind could do something illegal with our formalized codified  
published math files is totally irrelevant.  In the US (where I live,  
can't speak for other countries) we don't blame the gun manufacturers  
for what people do with submachine guns, so why should we blame the  
software developers (Read: practical mathematicians) for what people  
do with their programs?

Cheers,
Kyle Moffett

--
Simple things should be simple and complex things should be possible
   -- Alan Kay



