Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313557AbSDQTP2>; Wed, 17 Apr 2002 15:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSDQTP1>; Wed, 17 Apr 2002 15:15:27 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:28689 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S313557AbSDQTP0>;
	Wed, 17 Apr 2002 15:15:26 -0400
Date: Wed, 17 Apr 2002 11:14:31 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Larry McVoy <lm@bitmover.com>, David Brownell <david-b@pacbell.net>,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB device support for 2.5.8 (take 2)
Message-ID: <20020417181431.GA1162@kroah.com>
In-Reply-To: <20020417110809.R745@work.bitmover.com> <Pine.LNX.4.33.0204171156030.17829-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 20 Mar 2002 15:42:45 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 11:59:41AM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 17 Apr 2002, Larry McVoy wrote:
> >
> > What about "target"?
> 
> Well, it sounds unambiguous at least to me, and "makes sense".

I like "target" or "client", either of them work for me.

> Which still leaves the actual code implementation cleanliness issues, of
> course (modulo the USB documentation specifying that "target" means a
> small USB-controlled fish, thereby confusing all the USB developers).

Yes, I am working on this right now.  This will take a bit longer than
just renaming the directory and changing the documentation :)

thanks,

greg k-h
