Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEVxg>; Fri, 5 Jan 2001 16:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRAEVx1>; Fri, 5 Jan 2001 16:53:27 -0500
Received: from msp-65-25-230-128.mn.rr.com ([65.25.230.128]:41996 "HELO
	msp-65-25-230-128.mn.rr.com") by vger.kernel.org with SMTP
	id <S129183AbRAEVxT>; Fri, 5 Jan 2001 16:53:19 -0500
Date: Fri, 5 Jan 2001 15:53:03 -0600
From: Goblin <ahkbarr@yahoo.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: "chen, xiangping" <chen_xiangping@emc.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [OT] Re: boot up problem of IDE disk in 2.4.0!
Message-ID: <20010105155302.A20222@msp-65-25-230-128.mn.rr.com>
In-Reply-To: <276737EB1EC5D311AB950090273BEFDD979E4B@elway.lss.emc.com> <Pine.LNX.4.10.10101051334280.6736-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.10.10101051334280.6736-100000@master.linux-ide.org>; from andre@linux-ide.org on Fri, Jan 05, 2001 at 01:35:00PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You know, it makes me really love free OSes when I see a simple
question asked on the list, and it's answered by the guy who
writes the code!!!

Cheers to Alan, Andre, Linus, Rik, R. Gooch, Mingo, HPA and all
the rest who I forgot. You guys ROCK!

-Shawn

On 01/05, Andre Hedrick rearranged the electrons to read:
> 
> Maybe run make config and not make oldconfig.
> 
> 
> On Fri, 5 Jan 2001, chen, xiangping wrote:
> 
> > Hi, folks
> > 
> > I meet some problem when I tried by install kernel 2.4.0
> > to a PC using IDE disk. It reports VFS panic error during
> > boot up time when it tried to mount the rootfs. The error
> > indicates that it can not find the driver for the harddisk,
> > but I already build in the IDE disk support. The hard disk
> > is seagate ST310212A. The related content in .config file
> > is as follows. I would like to know what else I need to do.

 Your eyes are weary from staring at the CRT.  You feel sleepy.  Notice how
 restful it is to watch the cursor blink.  Close your eyes.  The opinions
 stated above are yours.  You cannot imagine why you ever felt otherwise.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
