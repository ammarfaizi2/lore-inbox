Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130512AbQLKWOH>; Mon, 11 Dec 2000 17:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130884AbQLKWNs>; Mon, 11 Dec 2000 17:13:48 -0500
Received: from [194.213.32.137] ([194.213.32.137]:1028 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130512AbQLKWNi>;
	Mon, 11 Dec 2000 17:13:38 -0500
Message-ID: <20001210233351.A2583@bug.ucw.cz>
Date: Sun, 10 Dec 2000 23:33:51 +0100
From: Pavel Machek <pavel@suse.cz>
To: Ben Ford <ben@kalifornia.com>, Chris Lattner <sabre@nondot.org>
Cc: linux-kernel@vger.kernel.org, orbit-list@gnome.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.LNX.4.21.0012081626140.7741-100000@www.nondot.org> <3A31B8CC.7030604@kalifornia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A31B8CC.7030604@kalifornia.com>; from Ben Ford on Fri, Dec 08, 2000 at 08:45:00PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This email is here to announce the availability of a port of ORBit (the
> > GNOME ORB) to the Linux kernel.  This ORB, named kORBit, is available from
> > our sourceforge web site (http://korbit.sourceforge.net/).  A kernel ORB
> > allows you to write kernel extensions in CORBA and have the kernel call
> > into them, or to call into the kernel through CORBA.  This opens the door
> > to a wide range of experiments/hacks:
> > 
> > * We can now write device drivers in perl, and let them run on the iMAC
> >   across the hall from you. :)
> 
> Why would you *ever* want to write a device driver in perl???

Well, why not? When I created driver for 3com homefree camera (USB),
it had to do lots of parsing, so perl was ideal language. [Well, I was
not able to make driver work; anyway it would be good driver to be
written in perl.]

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
