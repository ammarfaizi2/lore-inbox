Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268154AbUH1D4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268154AbUH1D4f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 23:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268149AbUH1D4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 23:56:35 -0400
Received: from dp.samba.org ([66.70.73.150]:7607 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266526AbUH1D4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 23:56:33 -0400
Date: Fri, 27 Aug 2004 20:56:29 -0700
From: Jeremy Allison <jra@samba.org>
To: Christoph Hellwig <hch@infradead.org>, Jeremy Allison <jra@samba.org>,
       Jamie Lokier <jamie@shareable.org>, Rik van Riel <riel@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, Diego Calleja <diegocg@teleline.es>,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040828035629.GE1285@jeremy1>
Reply-To: Jeremy Allison <jra@samba.org>
References: <Pine.LNX.4.58.0408261217140.2304@ppc970.osdl.org> <Pine.LNX.4.44.0408261607070.27909-100000@chimarrao.boston.redhat.com> <20040826204841.GC5733@mail.shareable.org> <20040826205218.GE1570@legion.cup.hp.com> <20040827101956.B29672@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040827101956.B29672@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 10:19:56AM +0100, Christoph Hellwig wrote:
> 
> Maybe you should learn from netatalk.

I am well aware of what netatalk does. However netatalk
isn't as widely used as Samba. Things they can get away
with would cause our user community to flay us alive.

We need a proper solution, not a nasty hack.

That's like me telling you to "learn from *BSD". You have
different user constituencies, you have to serve yours,
I have to serve mine.

Jeremy.
