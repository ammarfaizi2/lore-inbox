Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315568AbSECG3b>; Fri, 3 May 2002 02:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315569AbSECG3a>; Fri, 3 May 2002 02:29:30 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:32290 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315568AbSECG32>; Fri, 3 May 2002 02:29:28 -0400
Date: Fri, 3 May 2002 08:30:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Ralf Baechle <ralf@uni-koblenz.de>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: discontiguous memory platforms
Message-ID: <20020503083009.W11414@dualathlon.random>
In-Reply-To: <Pine.LNX.4.21.0205021539460.23113-100000@serv> <E172yOR-00026G-00@starship> <3CD184BB.ED7F349F@linux-m68k.org> <E173LNK-00027F-00@starship> <3CD19640.3B85BF76@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 09:40:48PM +0200, Roman Zippel wrote:
> mapping won't be one to one, but you won't need another abstraction and
> the current vm is already basically able to handle it.

this was basically my whole point, agreed.

Andrea
