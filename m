Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131708AbRBAViY>; Thu, 1 Feb 2001 16:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131587AbRBAViO>; Thu, 1 Feb 2001 16:38:14 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:39444 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129895AbRBAVh7>; Thu, 1 Feb 2001 16:37:59 -0500
Message-Id: <200102012138.f11LcV322920@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Pavel Machek <pavel@suse.cz>
cc: Yi Li <yili@sgi.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: XFS file system Pre-Release 
In-Reply-To: Message from Pavel Machek <pavel@suse.cz> 
   of "Thu, 01 Feb 2001 20:17:03 +0100." <20010201201703.A123@bug.ucw.cz> 
Date: Thu, 01 Feb 2001 15:38:31 -0600
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi!
> 
> > We will be demonstrating XFS as the root file system for high availability
> > and clustering solutions in SGI systems at LinuxWorld New York from January
> > 31 to February 2. Free XFS CDs will also be available at LinuxWorld.
> 
> What support does XFS provide for clustering?
> 								Pavel

This statement is a little misleading, the clustering software is other
stuff from SGI, they just have xfs filesystems on the machines. Now CXFS
is another story, but it only exists for Irix now and it is almost certainly
not going to be open source when it is available for Linux (and yes I know
that makes packaging and support really interesting).

Steve

> -- 
> I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
> Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
