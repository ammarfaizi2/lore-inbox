Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280448AbRLQPd5>; Mon, 17 Dec 2001 10:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280537AbRLQPdr>; Mon, 17 Dec 2001 10:33:47 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:64803 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280448AbRLQPdm>; Mon, 17 Dec 2001 10:33:42 -0500
Date: Mon, 17 Dec 2001 16:33:15 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: 2.4.17rc1aa1
Message-ID: <20011217163315.Z2431@athlon.random>
In-Reply-To: <20011214181444.B2431@athlon.random> <20011215045255.04C6E8A6E5@cx518206-b.irvn1.occa.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011215045255.04C6E8A6E5@cx518206-b.irvn1.occa.home.com>; from barryn@pobox.com on Fri, Dec 14, 2001 at 08:52:55PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2001 at 08:52:55PM -0800, Barry K. Nathan wrote:
> Andrea Arcangeli wrote:
> > 
> > Marcelo, can you merge the loop-deadlock fix? (the others aren't
> > trivially mergeable yet and for the tcp conntrack you'd need to ask
> > Rusty first, the change is simple enough that I merged it for now)
> 
> I verified on two of my systems that the loop-deadlock fix patch works.

good, thanks.

Andrea
