Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRAXXwb>; Wed, 24 Jan 2001 18:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132111AbRAXXwK>; Wed, 24 Jan 2001 18:52:10 -0500
Received: from selene.cps.intel.com ([192.198.165.10]:64528 "EHLO
	selene.cps.intel.com") by vger.kernel.org with ESMTP
	id <S129406AbRAXXvw>; Wed, 24 Jan 2001 18:51:52 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE5DA@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'alex@foogod.com'" <alex@foogod.com>, Mark Smith <mark@winksmith.com>
Cc: Steven Ellmore <steve@signalstorm.com>,
        Steve Underwood <steveu@coppice.org>, linux-kernel@vger.kernel.org
Subject: RE: Probably Off-topic Question...
Date: Wed, 24 Jan 2001 15:49:39 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are correct, this is supposed to be handled by ACPI. However, this has
yet to be implemented in Linux's ACPI support. Check back in 6 months. :)

Regards -- Andy

> -----Original Message-----
> From: alex@foogod.com [mailto:alex@foogod.com]
> Sent: Wednesday, January 24, 2001 2:52 PM
> To: Mark Smith
> Cc: Steven Ellmore; Steve Underwood; linux-kernel@vger.kernel.org
> Subject: Re: Probably Off-topic Question...
> Importance: High
> 
> 
> On Wed, Jan 24, 2001 at 05:38:54PM -0500, Mark Smith wrote:
> > On Wed, Jan 24, 2001 at 07:40:14PM +0000, Steven Ellmore wrote:
> > > My VAIO Z505HS brightness control works under Linux.
> > > 
> > > Shift + Fn + Brightness (F5) dims
> > > Fn + Brightness brightens
> [...]
> > none of these things change my brightness one way or the other.
> > in particular, which part of the OS would be responsible for
> > watching these keystrokes and making the appropriate changes?
> 
> With the Z505H/J series, this is handled entirely by the BIOS 
> and the OS has 
> no part of it.  I'm not sure about the L's, but they're 
> otherwise fairly 
> similar to the H/J's.  (I have absolutely no idea about other 
> lines like the 
> picturebooks, of course, as the different lines from Sony are 
> effectively 
> completely unrelated.)
> 
> > others have told me about this keystroke.  someone had suggested
> > that this works differently on my system because i have a newer
> > bios?
> 
> This is possible.  I don't know why they would change this, 
> unless it was some 
> requirement of propertly integrating the newer Windows 
> versions, which is 
> possible.  In this case, my guess is that it's probably 
> exposed via ACPI or 
> something similar.  Any ACPI folks got thoughts on this as a 
> possibility (and 
> how one might find out)?  I have to admit I haven't played 
> with it much.
> 
> -alex
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
