Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbTJDQlM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 12:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbTJDQlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 12:41:11 -0400
Received: from gprs150-221.eurotel.cz ([160.218.150.221]:3202 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262695AbTJDQlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 12:41:09 -0400
Date: Sat, 4 Oct 2003 18:39:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Stan Bubrouski <stan@ccs.neu.edu>
Cc: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix oops after saving image
Message-ID: <20031004163927.GA450@elf.ucw.cz>
References: <20031002203906.GB7407@elf.ucw.cz> <Pine.LNX.4.44.0310031433530.28816-100000@cherise> <20031003223352.GB344@elf.ucw.cz> <3F7E57E9.8070904@ccs.neu.edu> <20031004080239.GA213@elf.ucw.cz> <3F7EF4A0.7060504@ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F7EF4A0.7060504@ccs.neu.edu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>>+ *    Note: The buffer we allocate to use to write the suspend header is
> >>>+ *    not freed; its not needed since system is going down anyway
> >>>+ *    (plus it causes oops and I'm lazy^H^H^H^Htoo busy).
> >>>+ */
> >>
> >>Too lazy to properly fix your comment as well.
> >
> >
> >Can you elaborate?
> >								Pavel
> 
> Pavel what mail client are you using?  The last comment
> reads:
> + *    (plus it causes oops and I'm lazy<CTRL-H><CTRL-H><CTRL-H><CTRL-H>too 
> busy).
> 
> I spelled out the ^H so you can see them, that is how
> the comment looks to me.  The word 'lazy' is still in
> there along with too busy, you never backspaced over
> the lazy in the comment.  That's all :P

:-))))))))))))))))))))))

No, my mail client is okay. I actually wrote ^ and H, and that should
be a joke.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
