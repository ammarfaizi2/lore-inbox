Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314709AbSEBSAn>; Thu, 2 May 2002 14:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315214AbSEBSAm>; Thu, 2 May 2002 14:00:42 -0400
Received: from dsl-213-023-038-046.arcor-ip.net ([213.23.38.46]:59551 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314709AbSEBSAk>;
	Thu, 2 May 2002 14:00:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: discontiguous memory platforms
Date: Wed, 1 May 2002 19:59:53 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrea Arcangeli <andrea@suse.de>, Ralf Baechle <ralf@uni-koblenz.de>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0205021539460.23113-100000@serv> <E172umC-0001zd-00@starship> <3CD17DCE.B7DB465D@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E172yOR-00026G-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 May 2002 19:56, Roman Zippel wrote:
> Daniel Phillips wrote:
> 
> > Maybe this is a good place to try out a hash table variant of
> > config_nonlinear.  It's got to be more efficient than searching all the
> > nodes, don't you think?
> 
> Most of the time there are only a few nodes, I just don't know where and
> how big they are, so I don't think a hash based approach will be a lot
> faster. When I'm going to change this, I'd rather try the dynamic table
> approach.

Which dynamic table approach is that?

-- 
Daniel
