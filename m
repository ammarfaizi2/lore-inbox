Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbUKPREV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbUKPREV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 12:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbUKPREV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 12:04:21 -0500
Received: from mail.kroah.org ([69.55.234.183]:6119 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262044AbUKPRER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 12:04:17 -0500
Date: Tue, 16 Nov 2004 09:03:39 -0800
From: Greg KH <greg@kroah.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: rcpt-linux-fsdevel.AT.vger.kernel.org@jankratochvil.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041116170339.GD6264@kroah.com>
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org> <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu> <84144f0204111602136a9bbded@mail.gmail.com> <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu> <20041116120226.A27354@pauline.vellum.cz> <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu> <20041116163314.GA6264@kroah.com> <E1CU6SL-0007FP-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CU6SL-0007FP-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 05:45:25PM +0100, Miklos Szeredi wrote:
> > > Well, 'Documentation/devices.txt' says:
> > > 
> > >   THE DEVICE REGISTRY IS OFFICIALLY FROZEN FOR LINUS TORVALDS' KERNEL
> > >   TREE.  At Linus' request, no more allocations will be made official
> > >   for Linus' kernel tree; the 3 June 2001 version of this list is the
> > >   official final version of this registry.
> > 
> > Not true, you can get new numbers.
> 
> I don't understand, what's the reason for this warning then?  To scare
> away developers wanting to allocate lots of device numbers?

It's an old message, and yes, it's there to scare people away.  Glad to
see it's working :)

thanks,

greg k-h
