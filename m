Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131397AbQKNWry>; Tue, 14 Nov 2000 17:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131510AbQKNWro>; Tue, 14 Nov 2000 17:47:44 -0500
Received: from nat-su-33.valinux.com ([198.186.202.33]:17006 "EHLO
	phenoxide.engr.valinux.com") by vger.kernel.org with ESMTP
	id <S131397AbQKNWr3>; Tue, 14 Nov 2000 17:47:29 -0500
Date: Tue, 14 Nov 2000 14:17:26 -0800
From: Johannes Erdfelt <jerdfelt@valinux.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [announce] New Maintainer
Message-ID: <20001114141726.D897@valinux.com>
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDCE3@orsmsx31.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
X-Mailer: Mutt 1.0.1i
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDCE3@orsmsx31.jf.intel.com>; from randy.dunlap@intel.com on Tue, Nov 14, 2000 at 07:35:27AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii

On Tue, Nov 14, 2000, Dunlap, Randy <randy.dunlap@intel.com> wrote:
> 2000-November-14
> 
> To the Linux-USB community:
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Intel has some other Linux areas that they would like for me
> to work on, so I need to transfer the USB maintainer role to
> someone else.
> 
> Linus says that it's my job to name the next maintainer,
> so I'm happy to announce that effective immediately, the
> Linux-USB maintainer is Johannes Erdfelt (jerdfelt@valinux.com).
> I am confident that Johannes will do a fine job as the
> USB maintainer.  Please give him your support just as you
> gave it to me (and indeed to the entire Linux-USB project).
> 
> We'll have to see if he also wants to take charge of the
> Slashdot Beanie Award stuff.  He's welcome to it if he
> wants it.  TBD.  :)
> 
> I've had a wonderful experience being the Linux-USB
> maintainer and I've enjoyed working with all of you.
> I'll still be around, working on USB and some other
> Linux things.
> 
> I'm especially thankful to Johannes, Greg Kroah-Hartman, and
> Vojtech Pavlik (SuSE) for substituting for me when I traveled,
> and to David Brownell, Pat Beirne (Corel), and Johannes
> for their participation in the USB PlugFest in August/2000.

I'd like to also thank Randy for all of the work he has done for the Linux
USB project.

I don't intend to handle the job much differently than Randy has. It seems
to have worked quite well.

Here's a patch to the MAINTAINERS file against 2.4.0-test11-pre5 to
"officially" make the change.

JE


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb-maintainer.patch"

--- linux-2.4.0-test11-pre5.orig/MAINTAINERS	Tue Nov 14 14:00:07 2000
+++ linux-2.4.0-test11-pre5/MAINTAINERS	Tue Nov 14 14:03:41 2000
@@ -1245,8 +1245,9 @@
 S:	Maintained
 
 USB SUBSYSTEM
-P:	Randy Dunlap
-M:	randy.dunlap@intel.com
+P:	Johannes Erdfelt
+M:	jerdfelt@valinux.com
+M:	johannes@erdfelt.com
 L:	linux-usb-users@lists.sourceforge.net
 L:	linux-usb-devel@lists.sourceforge.net
 W:	http://www.linux-usb.org

--FL5UXtIhxfXey3p5--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
