Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293595AbSCPAWk>; Fri, 15 Mar 2002 19:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293591AbSCPAW3>; Fri, 15 Mar 2002 19:22:29 -0500
Received: from mail.actcom.co.il ([192.114.47.13]:40162 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S293595AbSCPAWP>; Fri, 15 Mar 2002 19:22:15 -0500
Message-Id: <200203160022.g2G0MNf08219@lmail.actcom.co.il>
Content-Type: text/plain; charset=US-ASCII
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: Greg KH <greg@kroah.com>
Subject: Re: USB-Storage in 2.4.19-pre
Date: Sat, 16 Mar 2002 02:22:11 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200203141432.g2EEWL628078@lmail.actcom.co.il> <20020315182603.GC4310@kroah.com> <200203152223.g2FMNDf21690@lmail.actcom.co.il>
In-Reply-To: <200203152223.g2FMNDf21690@lmail.actcom.co.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 March 2002 00:23 am, Itai Nahshon wrote:
> On Friday 15 March 2002 20:26 pm, Greg KH wrote:
> > On Fri, Mar 15, 2002 at 02:50:15AM +0200, Itai Nahshon wrote:
> > > Again, I do not see the disk usind usbview (or in
> > > /proc/bus/usb/devices) so I believe the problem is more with detection
> > > than with initialization.
> >
> > Sounds like it's a flaky USB device :)
> >
> > Does this device work on any other machines?
>
> I use it on my computers at home and in the office. Very handy
> when I want to share large data. It also worked on Windows 98
> (with their supplied diricer on diskette from DataStor) until I
> reformatted the disk as EXT3.
>
I forgot to say, that's with different mainboards, At home that's
via694 based ASUS CUV4X. In the office it's a MicroStar (do not
remember model) MB with 440BX chipset and I'm sure I successfully
used that disk also on noname MB with i810 chipset. All systems
using Linux 2.4.x kernels.

-- Itai
