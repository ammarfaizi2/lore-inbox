Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315285AbSEGCUd>; Mon, 6 May 2002 22:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315286AbSEGCUc>; Mon, 6 May 2002 22:20:32 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:58054 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315285AbSEGCUb>;
	Mon, 6 May 2002 22:20:31 -0400
Date: Tue, 7 May 2002 12:20:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: TRIVIAL: Remove warning in mm/memory.c
Message-ID: <20020507022014.GF1163@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Anton Altaparmakov <aia21@cantab.net>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020507011013.GD1163@zax> <5.1.0.14.2.20020507022951.01fadc60@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 02:32:15AM +0100, Anton Altaparmakov wrote:
> This is already removed in 2.5.14!

Oops, I was working 

> At 02:10 07/05/02, David Gibson wrote:
> >Linus, please apply.  This patch removes an unused variable in
> >mm/memory.c.

Oops, I was working of the linuxppc-2.5 bk tree and forget to check
that it was up to date with the Linus tree.  Sorry.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson
