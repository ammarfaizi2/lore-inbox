Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261641AbSJVTuQ>; Tue, 22 Oct 2002 15:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261657AbSJVTuQ>; Tue, 22 Oct 2002 15:50:16 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:45792 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261641AbSJVTuP>;
	Tue, 22 Oct 2002 15:50:15 -0400
Date: Tue, 22 Oct 2002 20:57:30 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Rob Landley <landley@trommello.org>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Roman Zippel <zippel@linux-m68k.org>, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, akpm@zip.com.au, davem@redhat.com,
       mingo@redhat.com
Subject: Re: [STATUS 2.5]  October 21, 2002
Message-ID: <20021022195730.GA30958@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Rob Landley <landley@trommello.org>,
	Guillaume Boissiere <boissiere@adiglobal.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Roman Zippel <zippel@linux-m68k.org>, riel@conectiva.com.br,
	linux-kernel@vger.kernel.org, akpm@zip.com.au, davem@redhat.com,
	mingo@redhat.com
References: <20021021135137.2801edd2.rusty@rustcorp.com.au> <3DB3AB3E.23020.5FFF7144@localhost> <200210211522.35843.landley@trommello.org> <20021022194739.GB28822@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021022194739.GB28822@clusterfs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 01:47:39PM -0600, Andreas Dilger wrote:
 > On Monday 21 October 2002 06:22, Guillaume Boissiere wrote:
 > > Also, are initramfs, ext2/3 resize for 2.7/3.1?
 > 
 > The online resize stuff has been suffering because I've been terribly
 > busy at work.  Even so, it can be merged after the 2.5 code freeze,
 > since it is internal to ext3 and does not affect any APIs.

Nevertheless, it means any ext3 stability testing done post-freeze
would be invalidated by addition of a new _feature_.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
