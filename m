Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262706AbRFCA72>; Sat, 2 Jun 2001 20:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262711AbRFCA7S>; Sat, 2 Jun 2001 20:59:18 -0400
Received: from schmee.sfgoth.com ([63.205.85.133]:38660 "EHLO
	schmee.sfgoth.com") by vger.kernel.org with ESMTP
	id <S262706AbRFCA7G>; Sat, 2 Jun 2001 20:59:06 -0400
Date: Sat, 2 Jun 2001 18:00:37 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: symlink_prefix
Message-ID: <20010602180037.B49864@sfgoth.com>
In-Reply-To: <UTC200106022354.BAA182685.aeb@vlet.cwi.nl> <Pine.GSO.4.21.0106022036200.25668-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.GSO.4.21.0106022036200.25668-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Jun 02, 2001 at 08:49:03PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> I can see how to implement per-mountpoint variant. However, I'm
> less than enthusiastic about the API side of that and about the
> ugliness it will lead to. It smells like a wrong approach. And
> no, I don't see a good one right now.

Aren't we one day going to have stackable filesystems?  This looks like an
idea for a trivial translation filesystem to me.

-Mitch
