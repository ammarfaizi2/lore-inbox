Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289204AbSAGNgF>; Mon, 7 Jan 2002 08:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289209AbSAGNfr>; Mon, 7 Jan 2002 08:35:47 -0500
Received: from ns1.baby-dragons.com ([199.33.245.254]:173 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S289212AbSAGNfV>; Mon, 7 Jan 2002 08:35:21 -0500
Date: Mon, 7 Jan 2002 08:35:12 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Dave Jones <davej@suse.de>
cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <Pine.LNX.4.33.0201061918090.3859-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.43.0201070815380.23683-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Dave ,

On Sun, 6 Jan 2002, Dave Jones wrote:
> On Sun, 6 Jan 2002, Mr. James W. Laferriere wrote:
> > 	And what is there to replace /proc/ide ?  I see no other facility
> > 	in /proc to do the job .  Again am I missing something here ?
> 99% of everything done by /proc/ide/ can be done in userspace by parsing
> /proc/bus/pci. The remaining 1% can be done with ioctls.
	Hmm ,  I see there is some info in ide .  But I don't see it as
	being very setable .  OK ,  I am beginning to see what you are
	speaking of .  ide looks like it wasn't completed to me .

> The info exposed by /proc/scsi may be exposed by ioctls also, (in which
> case, that too can be done entirely in userspace), however, I'm not sure
> everything shown there is accessable by means other than proc parsing.
	Not sure either ,  And I am sure you would have more idea than
	I .  I like scsi's completeness & setability .
	Thank you for filling me in .  JimL

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

