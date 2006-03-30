Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWC3Jf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWC3Jf5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 04:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWC3Jf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 04:35:57 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:33488 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932140AbWC3Jf4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 04:35:56 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Suspend2-2.2.2 for 2.6.16.
Date: Thu, 30 Mar 2006 11:34:48 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Mark Lord <lkml@rtr.ca>,
       suspend2-announce@lists.suspend2.net, linux-kernel@vger.kernel.org
References: <200603281601.22521.ncunningham@cyclades.com> <20060329091909.GA11438@elf.ucw.cz> <200603292050.33622.ncunningham@cyclades.com>
In-Reply-To: <200603292050.33622.ncunningham@cyclades.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603301134.49089.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 29 March 2006 12:50, Nigel Cunningham wrote:
> On Wednesday 29 March 2006 19:19, Pavel Machek wrote:
> > On Út 28-03-06 18:51:51, Mark Lord wrote:
> > > Nigel Cunningham wrote:
> > > >Hi everyone.
> > > >
> > > >Suspend2, version 2.2.2 is now available from
> > > >
> > > >http://stage.suspend2.net/downloads/all/suspend2-2.2.2-for-2.6.16.tar.bz
> > > >2
> > >
> > > Wow!  Is this ever freaking fast!
> > > Try it folks.  Once you do, you'll never go back to the slow way!
> >
> > Please do try code at suspend.sf.net. It should be as fast and not
> > needing big kernel patch.
> 
> Don't bother suggesting that to x86_64 owners: compilation is currently broken  
> in vbetool/lrmi.c (at least).

You need to specify ARCH=x86_64 in the Makefile.

Unfortunately this has not been documented (yet).

Greetings,
Rafael
