Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbTDLAIu (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 20:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbTDLAIu (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 20:08:50 -0400
Received: from inet-mail2.oracle.com ([148.87.2.202]:15256 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id S262621AbTDLAIt (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 20:08:49 -0400
Date: Fri, 11 Apr 2003 17:19:13 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Greg KH <greg@kroah.com>
Cc: "Kevin P. Fleming" <kpfleming@cox.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030412001913.GG4917@ca-server1.us.oracle.com>
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net> <20030411192827.GC31739@ca-server1.us.oracle.com> <20030411195843.GO1821@kroah.com> <20030411232507.GC4917@ca-server1.us.oracle.com> <20030411233719.GD4539@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030411233719.GD4539@kroah.com>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 04:37:19PM -0700, Greg KH wrote:
> > if [ -f /etc/redhat-release ]
> > then
> >     DISKPREFIX="/dev/disk"
> 
> But all the distros will do that for you :)

	Oh no they won't.  They're just going to fix their own scripts
to accept their own scheme.  Never mind my own.  I want my own scheme,
the distro scripts break.  I want a script running out of shared NFS?
I lose.

> Then try to convince LSB to add a device naming document to their spec.
> That's the only way this is going to happen...

	LSB isn't even followed now.  What we need is a naming czar.  As
you point out, Good Luck.
	Linux devices are going to stop sucking from one perspective and
start sucking from another.  Yay.

Joel

-- 

"Can any of you seriously say the Bill of Rights could get through
 Congress today?  It wouldn't even get out of committee."
	- F. Lee Bailey

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
