Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268272AbUHQQIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268272AbUHQQIY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 12:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268319AbUHQQIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 12:08:24 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:6022 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S268272AbUHQQIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 12:08:05 -0400
Subject: Re: Coding style: do_this(a,b) vs. do_this(a, b)
From: Alexander Nyberg <alexn@telia.com>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, pavel@ucw.cz
In-Reply-To: <1092743463.5759.1403.camel@cube>
References: <1092743463.5759.1403.camel@cube>
Content-Type: text/plain
Message-Id: <1092758863.1948.2.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 17 Aug 2004 18:07:43 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-17 at 13:51, Albert Cahalan wrote:
> > Coding style document is not consistent with
> > itself on whether there should be space after
> > ","... This makes it standartize on ", " option.
> 
> You can read it both ways, right? It's easy.
> I can't even see the difference unless I'm
> looking for it.
> 
> We don't need any more bureaucracy.
> 
> do_this(a,b);
> do_this(a, b);
> do_this (a,b);
> do_this (a, b);
> 
> I can read them all. I might notice the space in
> front of the '(', but I might not. Even putting a
> space in front of the ';' isn't unreadable.
> 
> People will pass laws until they are choked off,
> unable to move without being in violation of some
> silly little thing.

Some of us do see it and find it very annoying, I'm one of those who
very much prefer do_this(a, b) and especially when there are 
more than two parameters.

One of the reasons I do like linux is the coding standard, I find many
other projects completely unreadable.

