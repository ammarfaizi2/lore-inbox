Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131483AbRBQNih>; Sat, 17 Feb 2001 08:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131679AbRBQNi2>; Sat, 17 Feb 2001 08:38:28 -0500
Received: from [194.213.32.137] ([194.213.32.137]:13060 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131483AbRBQNiK>;
	Sat, 17 Feb 2001 08:38:10 -0500
Message-ID: <20010214124512.D1931@bug.ucw.cz>
Date: Wed, 14 Feb 2001 12:45:12 +0100
From: Pavel Machek <pavel@suse.cz>
To: James Sutherland <jas88@cam.ac.uk>, "H. Peter Anvin" <hpa@transmeta.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: LILO and serial speeds over 9600
In-Reply-To: <3A884D72.E0F3D354@transmeta.com> <Pine.SOL.4.21.0102122158510.22949-100000@yellow.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.SOL.4.21.0102122158510.22949-100000@yellow.csi.cam.ac.uk>; from James Sutherland on Mon, Feb 12, 2001 at 10:55:21PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I might just decide to do the kernel as well.
> > 
> > Hmmm... this sounds like it's turning into a group effort.  Would you (or
> > someone else) like to set up a sourceforge project for this?  I would
> > prefer not to have to deal with that end myself.
> 
> OK, I've filled in the paperwork - we should have a project account
> sometime tomorrow. I put the license type as "Other", since the heart of
> the project is the protocol, and patches to add support to the kernel,
> FreeBSD etc. will have to be under the license of the OS in question.
> 
> Title: "Network Console Protocol" for now?

Hey, be sure to add magic keys over network console protocol (-:. I
(and mj) long time ago wanted to do magic keys over network, and it
should be pretty easy to add onto network console...
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
