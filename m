Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbTJXRGi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 13:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbTJXRGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 13:06:38 -0400
Received: from havoc.gtf.org ([63.247.75.124]:63204 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262407AbTJXRGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 13:06:37 -0400
Date: Fri, 24 Oct 2003 13:06:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Eric Anholt <eta@lclark.edu>,
       kronos@kronoz.cjb.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       dri-devel <dri-devel@lists.sourceforge.net>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver conversion
Message-ID: <20031024170636.GA28582@gtf.org>
References: <3F987E18.9080606@pobox.com> <Pine.LNX.4.44.0310240931090.6051-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310240931090.6051-100000@home.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 24, 2003 at 09:44:38AM -0700, Linus Torvalds wrote:
> So wouldn't it be nice if we just had those ten lines as a generic
> function like
> 
> 	int pci_enable_rom(struct pci_device *dev)
> 	{
> 		...
> 
> 	int pci_disable_rom(..);

Yes.  Agreed,

	Jeff



