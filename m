Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265592AbSKACcu>; Thu, 31 Oct 2002 21:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265598AbSKACcu>; Thu, 31 Oct 2002 21:32:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59402 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265592AbSKACcs>; Thu, 31 Oct 2002 21:32:48 -0500
Date: Thu, 31 Oct 2002 18:39:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2002-Q4@gmx.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Xiafs inclusion in 2.5?
In-Reply-To: <3DC18308.1040808@gmx.net>
Message-ID: <Pine.LNX.4.44.0210311837060.2487-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Oct 2002, Carl-Daniel Hailfinger wrote:
> 
> Out of curiosity, would you reaccept xiafs in 2.5, if it was cleaned up and 
> forward ported to use the new interfaces?

Quite frankly, I probably _would_ accept it, if it's cleanly done. If only 
because of the fact that it's such a ridiculous thing to do, and thus gets 
high points on my "surreality meter".

> And if you accept it, what's the latest date I could submit it? Technically, 
> it is a regression, ;-) so the feature freeze date might not apply.

Yeah, I think xiafs has little to do with a feature freeze. It has little 
to do with sanity too, for that matter. I saw that Andries still has one 
xia floppy somewhere, and that probably puts him in a rather unique 
position. I can't imagine that very many people really care, but it's a 
ironic form of retrocomputing...

		Linus

