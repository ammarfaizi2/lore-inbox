Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTGXMMl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 08:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbTGXMMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 08:12:41 -0400
Received: from hal-4.inet.it ([213.92.5.23]:26503 "EHLO hal-4.inet.it")
	by vger.kernel.org with ESMTP id S263398AbTGXMMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 08:12:40 -0400
Date: Thu, 24 Jul 2003 14:39:08 +0200
From: Mattia Dongili <dongili@supereva.it>
To: junkio@cox.net
Cc: Norman Diamond <ndiamond@wta.att.ne.jp>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keycode 183 in defkeymap.map (was Re: Japanese keyboards broken in 2.6)
Message-ID: <20030724123908.GA637@inferi.kami.home>
Reply-To: dongili@supereva.it
Mail-Followup-To: junkio@cox.net, Norman Diamond <ndiamond@wta.att.ne.jp>,
	linux-kernel@vger.kernel.org
References: <fa.i0hls5p.1rneqjr@ifi.uio.no> <7vznj4ua3e.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7vznj4ua3e.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 03:55:33PM -0700, junkio@cox.net wrote:
> >>>>> "ND" == Norman Diamond <ndiamond@wta.att.ne.jp> writes:
> 
> ND> "Andries Brouwer" <aebr@win.tue.nl> replied to me, thank you.  Again, sorry
> ND> I cannot keep up with the mailing list.  If Dr. Brouwer or anyone else has
> ND> advice or questions, please contact me directly.  I am sending this both
> ND> personally and to the list.
> 
> I also got help from Brouwer with a similar (maybe the same)
> problem.  Although his "keycode 183 = backslash bar" comment is
> a bit cryptic, but here is what I did and worked:
[...] 
> For your convenience, I have attached patch that updates
> defkeymap.c and defkeymap.map to include the key definition, so
> you do not have to recompile loadkeys just to regenerate
> defkeymap.c file.  You should be able to apply the following to
> your 2.6.0-test1 source and rebuild the kernel.

thanks, it works as expected, my pipe key is back!
-- 
mattia
:wq!
