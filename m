Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317424AbSGRIyd>; Thu, 18 Jul 2002 04:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317429AbSGRIyd>; Thu, 18 Jul 2002 04:54:33 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:64485 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317424AbSGRIyc>;
	Thu, 18 Jul 2002 04:54:32 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Remain Calm: Designated initializer patches for 2.5 
Cc: linux-kernel@vger.kernel.org, Art Haas <ahaas@neosoft.com>
In-reply-to: Your message of "Wed, 17 Jul 2002 23:32:35 MST."
             <3D366103.8010403@zytor.com> 
Date: Thu, 18 Jul 2002 17:46:53 +1000
Message-Id: <20020718085813.8DF8C41A3@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3D366103.8010403@zytor.com> you write:
> As far as I could tell, *ALL* of these changes broke text alignment in 
> columns.

True.

> It would have been a lot better if they had maintained spacing; I
> find the new code much more cluttered and hard to read.

I thought about this: I agree it doesn't look as neat, but "hard to
read" for what purpose?  It's just as easy to find a particular field
you're looking for and it's just as easy to find the end of the
declaration: I couldn't come up with a convincing argument for needing
to skim-read these declarations, so I didn't complain to the author.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
