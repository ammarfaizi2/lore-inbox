Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269589AbUHZU27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269589AbUHZU27 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269603AbUHZU1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:27:48 -0400
Received: from mail.shareable.org ([81.29.64.88]:3015 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S269560AbUHZUSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:18:41 -0400
Date: Thu, 26 Aug 2004 21:16:39 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Jonathan Abbey <jonabbey@arlut.utexas.edu>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Diego Calleja <diegocg@teleline.es>, christophe@saout.de,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826201639.GA5733@mail.shareable.org>
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com> <200408262128.41326.vda@port.imtp.ilyichevsk.odessa.ua> <20040826193617.GA21248@arlut.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826193617.GA21248@arlut.utexas.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Abbey wrote:
> | Will it work out if "dir inside file" will only be visible when
> referred as "file/."?
> 
> I'm used to using ls symlink/. to get ls to show me the directory on
> the far side of a symbolic link.  That's a pretty analagous case to
> the one we're discussing here, I think?

By the way, do symlinks have metadata?  Where do you find it? :)

-- Jamie
