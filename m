Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288117AbSAQCgc>; Wed, 16 Jan 2002 21:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288124AbSAQCgN>; Wed, 16 Jan 2002 21:36:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11790 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288117AbSAQCgC>; Wed, 16 Jan 2002 21:36:02 -0500
From: Daniel Quinlan <quinlan@transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15430.14470.999605.380374@sodium.transmeta.com>
Date: Wed, 16 Jan 2002 18:35:50 -0800 (PST)
To: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
Cc: Daniel Quinlan <quinlan@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cramfs updates for 2.4.17
In-Reply-To: <Pine.LNX.4.44.0201170218110.24496-100000@rudy.mif.pg.gda.pl>
In-Reply-To: <15430.9334.687743.46115@sodium.transmeta.com>
	<Pine.LNX.4.44.0201170218110.24496-100000@rudy.mif.pg.gda.pl>
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: quinlan@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?ISO-8859-2?Q?Tomasz=5FK=B3oczko?= writes:

> On Wed, 16 Jan 2002, Daniel Quinlan wrote:
> [..]
> > mkcramfs.c
> [..]
> 
> Why not move this tool to util-linux ?

I'm actually ready to move the tools to sourceforge (the cramfs tools
CVS tree is there).

  http://sourceforge.net/projects/cramfs/

Assuming it's okay with Linus and Marcelo, I'll remove scripts/cramfs
in the next version of the patch (which should be fine for 2.5 too).

Dan
