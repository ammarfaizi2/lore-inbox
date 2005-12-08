Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbVLHRNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbVLHRNe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 12:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbVLHRNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 12:13:34 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:41743 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932221AbVLHRNe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 12:13:34 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: Kasper Sandberg <lkml@metanurb.dk>
To: Meelis Roos <mroos@linux.ee>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20051208083941.B233113E51@rhn.tartu-labor>
References: <20051208083941.B233113E51@rhn.tartu-labor>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 18:13:28 +0100
Message-Id: <1134062008.15056.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-08 at 10:39 +0200, Meelis Roos wrote:
> >> Some SiS based motherboards offer both an integrated video and AMD
> >> processor support.
> >> 
> KS> unfortunately that sis chip has a hardware bug (or so the xorg module
> KS> tells me) which makes dri impossible, and video overlay extremely bad..
> 
> Care to tell some more? I'm just considering purchasing a SiS or ULi
> based mainboard for AMD64 and would like to get the details about this
> SiS problem.
> 
this is my experience with my brothers laptop, its an asus, i cant
remember model off hand, it has a sempron 3000+ cpu, and some sis
chipset.

i installed linux on it due to him having excessive windows problems..
the xorg log told me i couldnt get dri, because of some hardware
problem, then it gave me a link, which i cant remember either, which
explained much more in detail about this.. and the thing about the video
overlay i do remember, it was something about some shared memory it uses
for the card which made the video overlay not work good, in both windows
and linux as far as i remember.. and it was true, video did sometimes
stutter and such.. and there is no dri..

i will contact my brother to get some more info..

