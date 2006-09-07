Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751794AbWIGPCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbWIGPCg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 11:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbWIGPCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 11:02:36 -0400
Received: from fremont.jonmasters.org ([64.71.152.22]:44044 "EHLO
	fremont.jonmasters.org") by vger.kernel.org with ESMTP
	id S1751794AbWIGPCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 11:02:35 -0400
From: Jon Masters <jonathan@jonmasters.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Victor Hugo <victor@vhugo.net>, linux-kernel@vger.kernel.org,
       Victor Castro <victorhugo83@yahoo.com>
In-Reply-To: <1157641826.30159.99.camel@aeonflux.holtmann.net>
References: <CB81ECDC-0B48-4BE4-B9C0-C1CDBEC0F739@vhugo.net>
	 <1157441620.24916.5.camel@localhost>
	 <508B6A67-CA5B-4A81-B868-BF8A03D78888@vhugo.net>
	 <1157560971.5265.94.camel@perihelion>
	 <1157641826.30159.99.camel@aeonflux.holtmann.net>
Content-Type: text/plain
Organization: World Organi[sz]ation Of Broken Dreams
Date: Thu, 07 Sep 2006 16:01:25 +0100
Message-Id: <1157641285.28216.18.camel@perihelion>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 212.18.227.82
X-SA-Exim-Mail-From: jonathan@jonmasters.org
Subject: Re: [PATCH][RFC] request_firmware examples and MODULE_FIRMWARE
X-SA-Exim-Version: 4.2 (built Thu, 14 Apr 2005 16:52:54 +0000)
X-SA-Exim-Scanned: Yes (on fremont.jonmasters.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-07 at 17:10 +0200, Marcel Holtmann wrote:
> Hi Jon,
> 
> > > > actually it has never been really a filename. It was a simple pattern
> > > > that the initial hotplug script and later the udev script mapped  
> > > > 1:1 to a filename on your filesystem. If you check the mailing list  
> > > > archives of LKML and linux-hotplug you will see that I always resisted
> > > > in allowing drivers to include a directory path in that call. A couple
> > > > of people tried this and it is not what it was meant to be.
> > 
> > That's fine. I agree with the idea - *but* it strikes me that we don't
> > really have a co-ordinated database of what module "patterns" map to
> > what on-disk firmware, aside from hotplug/udev scripts. We need to
> > co-ordinate this stuff a lot more. Or am I missing something? I'm happy
> > to setup a database on the kerneltools.org wiki if that's useful...
> 
> that is true, but it is actually not a problem of the kernel and your
> proposed MODULE_FIRMWARE patch. However it might be a good idea to start
> something like this. It will also help to see what is actually needed.

I reali[sz]e it's not a direct problem, but it does need fixing. I'll
spend some time over the weekend and then send an update about that.

Jon.


