Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268546AbTBWULr>; Sun, 23 Feb 2003 15:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268548AbTBWULr>; Sun, 23 Feb 2003 15:11:47 -0500
Received: from AGrenoble-101-1-6-25.abo.wanadoo.fr ([80.11.197.25]:58081 "EHLO
	awak") by vger.kernel.org with ESMTP id <S268546AbTBWULq>;
	Sun, 23 Feb 2003 15:11:46 -0500
Subject: Re: Minutes from Feb 21 LSE Call
From: Xavier Bestel <xavier.bestel@free.fr>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <b3b6oa$bsj$1@penguin.transmeta.com>
References: <E18moa2-0005cP-00@w-gerrit2>
	 <Pine.LNX.4.44.0302222354310.8609-100000@dlang.diginsite.com>
	 <20030223082036.GI10411@holomorphy.com>
	 <b3b6oa$bsj$1@penguin.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-15
Organization: 
Message-Id: <1046031687.2140.32.camel@bip.localdomain.fake>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 23 Feb 2003 21:21:27 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le dim 23/02/2003 à 20:17, Linus Torvalds a écrit :

> And the baroque instruction encoding on the x86 is actually a _good_
> thing: it's a rather dense encoding, which means that you win on icache. 
> It's a bit hard to decode, but who cares? Existing chips do well at
> decoding, and thanks to the icache win they tend to perform better - and
> they load faster too (which is important - you can make your CPU have
> big caches, but _nothing_ saves you from the cold-cache costs). 

Next step: hardware gzip ?

