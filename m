Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268025AbUH2PCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268025AbUH2PCX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 11:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268014AbUH2PCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 11:02:07 -0400
Received: from alias.nmd.msu.ru ([193.232.127.67]:22563 "EHLO alias.nmd.msu.ru")
	by vger.kernel.org with ESMTP id S267999AbUH2PAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 11:00:43 -0400
Date: Sun, 29 Aug 2004 19:00:41 +0400
From: Alexander Lyamin <flx@msu.ru>
To: Hans Reiser <reiser@namesys.com>
Cc: Rik van Riel <riel@redhat.com>, David Masover <ninja@slaphack.com>,
       Linus Torvalds <torvalds@osdl.org>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re:  silent semantic changes with reiser4
Message-ID: <20040829150041.GD9471@alias>
Reply-To: flx@msu.ru
Mail-Followup-To: flx@msu.ru, Hans Reiser <reiser@namesys.com>,
	Rik van Riel <riel@redhat.com>, David Masover <ninja@slaphack.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Diego Calleja <diegocg@teleline.es>, jamie@shareable.org,
	christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
	christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
	wichert@wiggy.net, jra@samba.org, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	flx@namesys.com, reiserfs-list@namesys.com
References: <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com> <412F7D63.4000109@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412F7D63.4000109@namesys.com>
X-Operating-System: Linux 2.6.5-7.104-smp
X-Fnord: +++ath
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Message-Flag: Message text blocked: ADULT LANGUAGE/SITUATIONS
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Aug 27, 2004 at 11:28:51AM -0700, Hans Reiser wrote:
> Rik van Riel wrote:
> 
> >
> >
> >Currently I see no way to distinguish between the stuff
> >that should be backed up and the stuff that shouldn't.
> >
> > 
> >
> We create filename/pseudos/backup, and that tells the archiver what to 
> do.....

its ugly idea.

representations should be distinguished from sources. and its reasonably
to put this distinguisher somewhere in namespace. but filename/pseudos/backup
is plain ugly.
-- 
"the liberation loophole will make it clear.."
lex lyamin
