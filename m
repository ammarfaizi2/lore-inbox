Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbTDYMSU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 08:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263900AbTDYMSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 08:18:20 -0400
Received: from codepoet.org ([166.70.99.138]:38838 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S263898AbTDYMST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 08:18:19 -0400
Date: Fri, 25 Apr 2003 06:24:00 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ALSA and 2.4.x
Message-ID: <20030425122400.GA25090@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20030424212508.GI14661@codepoet.org> <200304251401.36430.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304251401.36430.m.c.p@wolk-project.de>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Apr 25, 2003 at 02:01:36PM +0200, Marc-Christian Petersen wrote:
> On Thursday 24 April 2003 23:25, Erik Andersen wrote:
> 
> Hi Erik,
> 
> > > Is there a ALSA backport to 2.4.x anywhere?
> > I was crazy enough to take ALSA 0.9.2 and made it into a patch vs
> > 2.4.x a week or two ago.  I just prefer to have ALSA be part of
> > the kernel rather than needing to compile it seperately all the
> > time.  The patch, along with various other things, is included as
> > part of my 2.4.21-rc1-erik kernel:
> Are you sure that this is 0.9.2 ALSA? I am afraid it is 0.9.0-rc6.

Why are you afraid of that?  Yes I am sure it is 0.9.2.  I do
have a 0.9.0-rc6 patch on my site which is derived in part from
your wolk code.  But that is a different animal,

To make my 082_alsa-0.9.2.bz2 patch, I used the wolk 0.9.0-rc6
code, a copy of alsa-driver-0.9.2.tar.bz2, and a copy of the
latest 2.5.x kernel source for reference.  I then hacked on it
for a few hours till I made it work.

    <sound of checking>

Hahaha!  It looks like I copied my 0.9.0-rc6 patch over the top
of my 0.9.2 patch!  Oops.  I still have the source tree where I
hacked together the 0.9.2 kernel patch, so I'll regenerate that
and re-post it after I get some sleep.  <yawns, rubs eyes>

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
