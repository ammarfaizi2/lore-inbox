Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbTLWUF5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 15:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbTLWUF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 15:05:57 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:53972 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S262725AbTLWUFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 15:05:12 -0500
Date: Tue, 23 Dec 2003 12:06:40 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Giacomo A. Catenazzi" <cate@pixelized.ch>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: SCO's infringing files list
Message-ID: <20031223200640.GA64011@gaz.sfgoth.com>
References: <Pine.LNX.4.58.0312221337010.6868@home.osdl.org> <20031223002641.GD28269@pegasys.ws> <20031223092847.GA3169@deneb.enyo.de> <3FE811E3.6010708@debian.org> <Pine.LNX.4.58.0312230317450.12483@home.osdl.org> <3FE862E7.1@pixelized.ch> <20031223160425.GB45620@gaz.sfgoth.com> <20031223163926.GC45620@gaz.sfgoth.com> <Pine.LNX.4.58.0312230914090.14184@home.osdl.org> <1072205246.1702.36.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072205246.1702.36.camel@spc9.esa.lanl.gov>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:
> /* This is a list of all known signal numbers.  */
> 
> CONST char *CONST _sys_errlist[] = {

Note the incorrect comment (since its a list of error numbers, not signal
numbers).  It looks like the comment was originally from siglist.c in the
same directory.

I wonder if there are any UNIX sources which have a similar typo.  I somewhat
doubt it.

-Mitch
