Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261848AbSIXXYU>; Tue, 24 Sep 2002 19:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261849AbSIXXYU>; Tue, 24 Sep 2002 19:24:20 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:29754 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S261848AbSIXXYT>; Tue, 24 Sep 2002 19:24:19 -0400
Message-ID: <D9223EB959A5D511A98F00508B68C20C0A5389E2@orsmsx108.jf.intel.com>
From: "Rhoads, Rob" <rob.rhoads@intel.com>
To: "'Greg KH'" <greg@kroah.com>, "Rhoads, Rob" <rob.rhoads@intel.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [ANNOUNCE] Linux Hardened Device Drivers Project
Date: Tue, 24 Sep 2002 16:29:23 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Greg KH [mailto:greg@kroah.com]
> On Tue, Sep 24, 2002 at 02:46:35PM -0700, Rhoads, Rob wrote:
> > 
> > First throw away any idea of a spec. That was a bad idea. :)
> > 
> > Next, turn the first section, "Stability & Reliability" of our 
> > original doc into a "Driver Hardening HOWTO". It would be a 
> > list of characteristics that all good drivers should have, 
> > packed with examples to back it up. 
> 
> Sounds very good.  I recommend that it be written in DocBook and added
> to the Documentation/DocBook directory of the kernel tree.

Agreed. :-)

> 
> > BTW, by no means did I or anyone involved on this project, ever 
> > mean to imply that the current drivers in the kernel are "bad". 
> > Rather, I'd like to capture a list of the best practices and 
> > document them. In any event our current list needs to be 
> > strengthened with concrete examples. My thinking is that we 
> > should work with the Kernel Janitor project. This is where 
> > Intel can probably really help out.
> 
> Great, the janitor project can really use extra people to help out.  I
> suggest that you read over their TODO list again and pick up 
> the pieces
> from there that are missing from your "Driver Hardening HOWTO".

I will do.

[snip]

> 
> It would be wonderful if there were some good FI tools that were
> available for our use.  It can only help to make better drivers.
> 
> Thank you for your response, and for listening to the community.
> 
> greg k-h
>

-RobR
