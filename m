Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbTIMS1Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 14:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbTIMS1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 14:27:16 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:12811
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S261537AbTIMS1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 14:27:13 -0400
Date: Sat, 13 Sep 2003 11:09:29 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Timothy Miller <miller@techsource.com>
cc: David Schwartz <davids@webmaster.com>,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org
Subject: Re: People, not GPL  [was: Re: Driver Model]
In-Reply-To: <3F6234F7.80200@techsource.com>
Message-ID: <Pine.LNX.4.10.10309131053350.16744-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Timothy,

Who is talking about using "GPL source code", that is a given NO NO!
Calling symbols in the header files used as the generic functionality of
the kernel is all one could use in "Driver Model".  Beyond the simple
usage of header files, one is no longer in the land of API but usage of
raw GPL source.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Fri, 12 Sep 2003, Timothy Miller wrote:

> 
> 
> David Schwartz wrote:
> >>On Wed, 10 Sep 2003 22:40:14 +0200, you wrote in linux.kernel:
> > 
> > 
> >>>However, Richard Stallman does not agree with this view. It's his
> >>>view that if the authors chose to give you the code, you can use it any
> >>>way you want to, regardless of how the authors feel about that type of
> >>>usage. This is why he created the GPL.
> >>
> > 
> >>Use in any way you want to is the BSD license, not the GPL.
> > 
> > 
> > 	Please show me one restriction on *use* in the GPL.
> > 
> > "Activities other than copying, distribution and modification are not
> > covered by this License; they are outside its scope.  The act of
> > running the Program is not restricted, and the output from the Program
> > is covered only if its contents constitute a work based on the
> > Program (independent of having been made by running the Program).
> > Whether that is true depends on what the Program does."
> > 
> > 	Licenses that place restrictions on usage are *not* open source licenses.
> 
> 
> What about "usage" of source code?
> 
> GPL says you are not allowed to "use" GPL source in a non-free program 
> that you publish.
> 
> > 
> >>The GPL
> >>does restrict what you're allowed to do in order to keep the source
> >>free...
> > 
> > 
> > 	Yes, it restricts your ability to distribute and your ability to create
> > derived works if and only if you distribute those derived works. It places
> > no restrictions whatsoever on use. And since it requires distributors to
> > place no restrictions not in the GPL, distributors cannot place *any*
> > restrictions on usage either.
> 
> I don't think anyone was talking about use of applications, but rather 
> use of source code.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

