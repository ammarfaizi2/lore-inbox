Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270873AbTGNVIJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 17:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270870AbTGNVGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 17:06:24 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:32187 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S270868AbTGNVFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 17:05:19 -0400
Subject: Re: 2.6.0test 1 fails on eth0 up (arjanv RPM's - all needed rpms
	installed)
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: arjanv@redhat.com
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1058210139.5981.6.camel@laptop.fenrus.com>
References: <1058196612.3353.2.camel@aurora.localdomain>
	 <3F12FF53.7060708@pobox.com>  <1058210139.5981.6.camel@laptop.fenrus.com>
Content-Type: text/plain
Message-Id: <1058217601.4441.1.camel@aurora.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-2) 
Date: 14 Jul 2003 17:20:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-14 at 15:15, Arjan van de Ven wrote:
> On Mon, 2003-07-14 at 21:06, Jeff Garzik wrote:
> > Trever L. Adams wrote:
> > > OK, I now get past the initialization of the 3c920.  However, now it
> > > hangs (sak enabled, sak doesn't work... completely dead) when eth0 tries
> > > to come up.  I have IPv6 enabled (the router does 6to4, this isn't the
> > > router), I don't believe I have any firewall stuff on this box, it does
> > > dhcp for IPv4 address and ntp time.
> > 
> > 
> > hmmm... do you have the latest modutils installed?
> 
> of course he has; the kernel rpm requires: a good version.

More than that, I have been updating against rawhide and your stuff
since I started messing with your kernel rpms.  So, if you have it
uploaded to either of those and my system is using that functionality
(which modutils is obviously one of those), then I am running that
software.

I did get a version of 2.5.x to work, but I think that was back around
2.5.46 or something like that.  I had too many problems with Gnome back
then and so went back to 2.4.x.  Those have been fixed, so now I am
trying to help with testing.

Trever
--
"Love is friendship set on fire." -- French Proverb

