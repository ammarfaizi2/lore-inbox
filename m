Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262661AbSJGSQa>; Mon, 7 Oct 2002 14:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbSJGSQa>; Mon, 7 Oct 2002 14:16:30 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48656 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262661AbSJGSQa>; Mon, 7 Oct 2002 14:16:30 -0400
Date: Mon, 7 Oct 2002 11:21:08 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Mike Galbraith <efault@gmx.de>, Matthew Wilcox <willy@debian.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: bcopy()
In-Reply-To: <20021007191726.A23246@infradead.org>
Message-ID: <Pine.LNX.4.33.0210071118220.1356-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Oct 2002, Christoph Hellwig wrote:
> 
> The lowlevel XFS code tries to stay in sync as much as possible with
> the IRIX codebase to make maintaince easier (we're a very small team..).

Could somebody drag the Irix team kicking and screaming into the 1980's, 
please? 

I realize it might be quite painful for them, but maybe you could buy them 
a disco tape, so they'd feel a little bit more at home. 

		Linus "Stayin' alive, stayin' alive" Torvalds

