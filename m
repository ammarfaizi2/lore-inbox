Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313267AbSDYQE1>; Thu, 25 Apr 2002 12:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313293AbSDYQE0>; Thu, 25 Apr 2002 12:04:26 -0400
Received: from smokey.blackcatnetworks.co.uk ([212.135.138.139]:53174 "EHLO
	smokey.blackcatnetworks.co.uk") by vger.kernel.org with ESMTP
	id <S313267AbSDYQEY>; Thu, 25 Apr 2002 12:04:24 -0400
Date: Thu, 25 Apr 2002 17:04:13 +0100
From: Alex Walker <alex@x3ja.co.uk>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.10: 2 OOPs - "BUG at usb.c" and "unable to handle kernel paging request"
Message-ID: <20020425170413.V23497@x3ja.co.uk>
In-Reply-To: <20020424142132.K23497@x3ja.co.uk> <20020425074651.GA17368@kroah.com> <20020425133703.Q23497@x3ja.co.uk> <20020425145450.GA19161@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Look! It's Greg!

On Thu, Apr 25, 2002 at 07:54:50AM -0700, Greg KH wrote:
> On Thu, Apr 25, 2002 at 01:37:03PM +0100, Alex Walker wrote:
> > 'ello Greg On Thu, Apr 25, 2002 at 12:46:51AM -0700, Greg KH wrote:
> > > > Hi, I'm not subscribed - please CC me in any replies.  Two OOps
> > > > when running 2.5.10, as attached. With attatched config.  First
> > > > occurs on boot, but doesn't stop the whole system.  The second
> > > > occurs as I was rebooting - see the attached log to see where
> > > > they happen.  Any more info required?  Just ask.
> > > Known problem with the uhci driver right now, just use usb-uhci
> > > instead (not the ALT UHCI driver) for now until things get
> > > straightend out.
> > Yes, that's solved the first oops.  Is the second one related?
> Probably, does the second one still happen now?

Sorry, that would have been useful for me to say wouldn't it?  yes it
does still happen.

Alex.

-- 
"I'm returning this note to you, instead of your paper, because it (your
paper)
presently occupies the bottom of my bird cage."
  -- English Professor, Providence College
