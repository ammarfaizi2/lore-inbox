Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288327AbSAUBIc>; Sun, 20 Jan 2002 20:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285692AbSAUBIW>; Sun, 20 Jan 2002 20:08:22 -0500
Received: from ns1.baby-dragons.com ([199.33.245.254]:18830 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S288327AbSAUBIM>; Sun, 20 Jan 2002 20:08:12 -0500
Date: Sun, 20 Jan 2002 20:07:12 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Frank van de Pol <fvdpol@home.nl>, Keith Owens <kaos@ocs.com.au>,
        Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <5.1.0.14.2.20020121010328.02672020@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.44.0201202004440.914-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Anton ,

On Mon, 21 Jan 2002, Anton Altaparmakov wrote:
> At 23:20 20/01/02, Frank van de Pol wrote:
> >On Sat, Jan 19, 2002 at 10:22:43AM +1100, Keith Owens wrote:
> > > On Fri, 18 Jan 2002 17:20:02 -0500 (EST),
> > > "Mr. James W. Laferriere" <babydr@baby-dragons.com> wrote:
> > > >     Linux doesn't have a method to load encrypted & signed modules at
> > > >     this time .
> > > And never will.  Who loads the module - root.  Who maintains the list
> > > of signatures - root.  Who controls the code that verifies the
> > > signature - root.
> > > Your task Jim, should you choose to accept it, is to make the kernel
> > > distinguish between a good use of root and a malicious use by some who
> > > has broken in and got root privileges.  When you can do that, then we
> > > can add signed modules.
> >If you want to secure your box, why don't you simply put a lock on it and
> >throw away the key? Really, what might help the paranoid admins in this case
> >is a setting in the kernel which basically disables the ability to load or
> >unload modules. Of course once set this setting can not been turned with
> >rebooting the box.

> Er that sounds like just disabling modules in the kernel altogether (kernel
> compile option exists for this since the beginning of time)... I do that on
> all servers I control. Not only for security reasons but also because I
> suspect it produces smaller and probably faster kernels (I haven't tested
> this in any way, just a guess).
	This is just what the Heads are trying to do away with .  There
	will only be module enabled kernels .  JimL

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

