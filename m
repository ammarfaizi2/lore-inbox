Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbTLWUUS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 15:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbTLWUUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 15:20:18 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:25302 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S262760AbTLWUUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 15:20:12 -0500
Date: Tue, 23 Dec 2003 12:21:16 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Giacomo A. Catenazzi" <cate@pixelized.ch>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Eric S. Raymond" <esr@thyrsus.com>, Jonathan Magid <jem@ibiblio.org>,
       "H. J. Lu" <hjl@lucon.org>, "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: SCO's infringing files list
Message-ID: <20031223202116.GB64011@gaz.sfgoth.com>
References: <Pine.LNX.4.58.0312221337010.6868@home.osdl.org> <20031223002641.GD28269@pegasys.ws> <20031223092847.GA3169@deneb.enyo.de> <3FE811E3.6010708@debian.org> <Pine.LNX.4.58.0312230317450.12483@home.osdl.org> <3FE862E7.1@pixelized.ch> <20031223160425.GB45620@gaz.sfgoth.com> <20031223174454.GD45620@gaz.sfgoth.com> <Pine.LNX.4.58.0312230946010.14184@home.osdl.org> <20031223190656.GB15049@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223190656.GB15049@win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> I just uploaded a copy to
> ftp://ftp.win.tue.nl/pub/linux-local/libc.archive/libc/libc-222.taz

OK, so that takes us back to errlist.c modified 18-Jun-92:

% tar tvfz libc-222.taz | grep errlist
-rw-r--r-- hlu/other      5601 1992-06-18 21:58:54 ./libc-linux/string/errlist.c

And yes it includes the incorrect comment.

-Mitch
