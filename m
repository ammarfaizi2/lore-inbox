Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268028AbUH2PMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268028AbUH2PMX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 11:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268021AbUH2PMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 11:12:23 -0400
Received: from alias.nmd.msu.ru ([193.232.127.67]:50211 "EHLO alias.nmd.msu.ru")
	by vger.kernel.org with ESMTP id S268008AbUH2PMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 11:12:14 -0400
Date: Sun, 29 Aug 2004 19:12:12 +0400
From: Alexander Lyamin <flx@msu.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hans Reiser <reiser@namesys.com>, Helge Hafting <helgehaf@aitel.hist.no>,
       Rik van Riel <riel@redhat.com>, Spam <spam@tnonline.net>,
       Jamie Lokier <jamie@shareable.org>, David Masover <ninja@slaphack.com>,
       Diego Calleja <diegocg@teleline.es>, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       hch@lst.de, linux-fsdevel@vger.kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, flx@namesys.com,
       reiserfs-list@namesys.com,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re:  silent semantic changes with reiser4
Message-ID: <20040829151212.GG9471@alias>
Reply-To: flx@msu.ru
Mail-Followup-To: flx@msu.ru, Linus Torvalds <torvalds@osdl.org>,
	Hans Reiser <reiser@namesys.com>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	Rik van Riel <riel@redhat.com>, Spam <spam@tnonline.net>,
	Jamie Lokier <jamie@shareable.org>,
	David Masover <ninja@slaphack.com>,
	Diego Calleja <diegocg@teleline.es>, christophe@saout.de,
	vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
	Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
	hch@lst.de, linux-fsdevel@vger.kernel.org,
	Kernel Mailing List <linux-kernel@vger.kernel.org>, flx@namesys.com,
	reiserfs-list@namesys.com,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org> <20040828170515.GB24868@hh.idb.hist.no> <Pine.LNX.4.58.0408281038510.2295@ppc970.osdl.org> <4131074D.7050209@namesys.com> <Pine.LNX.4.58.0408282159510.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408282159510.2295@ppc970.osdl.org>
X-Operating-System: Linux 2.6.5-7.104-smp
X-Fnord: +++ath
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Message-Flag: Message text blocked: ADULT LANGUAGE/SITUATIONS
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Aug 28, 2004 at 10:01:23PM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 28 Aug 2004, Hans Reiser wrote:
> >
> > I object to openat().....
> 
> Sound slike you object to O_XATTRS, not openat() itself.

xattr deserve to be objected. 
quickiehackie design practice.

-- 
"the liberation loophole will make it clear.."
lex lyamin
