Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267859AbUH2N5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267859AbUH2N5n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 09:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267918AbUH2N52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 09:57:28 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:30732 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S267859AbUH2N4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 09:56:25 -0400
Date: Sun, 29 Aug 2004 15:56:17 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, viro@parcelfarce.linux.theplanet.co.uk,
       Helge Hafting <helgehaf@aitel.hist.no>, Rik van Riel <riel@redhat.com>,
       Spam <spam@tnonline.net>, Jamie Lokier <jamie@shareable.org>,
       Hans Reiser <reiser@namesys.com>, David Masover <ninja@slaphack.com>,
       Diego Calleja <diegocg@teleline.es>, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       hch@lst.de, linux-fsdevel@vger.kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040829135617.GA8021@pclin040.win.tue.nl>
References: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org> <20040828170515.GB24868@hh.idb.hist.no> <Pine.LNX.4.58.0408281038510.2295@ppc970.osdl.org> <20040828182954.GJ21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408281132480.2295@ppc970.osdl.org> <20040828185613.GK21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408281201290.2295@ppc970.osdl.org> <20040828194129.GA7713@pclin040.win.tue.nl> <Pine.LNX.4.58.0408281244340.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408281244340.2295@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: dmv.com: mailhost.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 12:46:10PM -0700, Linus Torvalds wrote:

> > Now there is no attribute space, just a shorthand.
> 
> It's more than a shorthand, though. _Much_ more.
> ...
> Both of those are why it would need special support.

Yes - support, I do not argue against that.
But I argue against an attribute space.

This xterm.icon was xterm.icons - with both large and small
icons. And these icons have copyrights. Etc. There is just
an arbitrary tree below this xterm filesystem object.
The files below are in no way different from the files above.

Unix says: everything is a file. Now we get: everything is
a directory. And some directories have a file attached.

Andries
