Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752656AbWKBVmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbWKBVmm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752653AbWKBVmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:42:42 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:27843 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1752656AbWKBVmm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:42:42 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.19-rc4: known unfixed regressions
Date: Thu, 2 Nov 2006 22:40:40 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Laurent Riffard <laurent.riffard@free.fr>,
       Rajesh Shah <rajesh.shah@intel.com>, toralf.foerster@gmx.de,
       Jeff Garzik <jeff@garzik.org>, Pavel Machek <pavel@ucw.cz>,
       Greg KH <greg@kroah.com>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <200611022102.02302.rjw@sisk.pl> <20061102212602.GI27968@stusta.de>
In-Reply-To: <20061102212602.GI27968@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611022240.41770.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 2 November 2006 22:26, Adrian Bunk wrote:
> On Thu, Nov 02, 2006 at 09:02:01PM +0100, Rafael J. Wysocki wrote:
> > Hi,
> 
> Ji Rafael,
> 
> > On Tuesday, 31 October 2006 20:56, you wrote:
> > > This email lists some known regressions in 2.6.19-rc4 compared to 2.6.18
> > > that are not yet fixed in Linus' tree.
> > 
> > Can we please add the following two to the list of known regressions:
> > 
> > http://bugzilla.kernel.org/show_bug.cgi?id=7082
> > http://bugzilla.kernel.org/show_bug.cgi?id=7207
> > 
> > They are regressions with respect to 2.6.17.x kernels, but still.
> >...
> 
> I'm sorry, but I'm only tracking regressions since 2.6.18 - "regressions 
> since the latest stable kernel" is a clear border, and the number of 
> post-2.6.18 regressions is high enough that adding even more 
> regressions to my list wouldn't make sense.

Fair enough.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
