Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265515AbUFIDQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265515AbUFIDQy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 23:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbUFIDQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 23:16:54 -0400
Received: from mail.kroah.org ([65.200.24.183]:19425 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265515AbUFIDQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 23:16:40 -0400
Date: Tue, 8 Jun 2004 20:15:44 -0700
From: Greg KH <greg@kroah.com>
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.7-rc3: NVidia graphics problem
Message-ID: <20040609031544.GA7998@kroah.com>
References: <Pine.LNX.4.58.0406071227400.2550@ppc970.osdl.org> <40C5EDAA.9040808@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C5EDAA.9040808@t-online.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2004 at 06:47:38PM +0200, Harald Dunkel wrote:
> I am not sure whether it is allowed to report problems with
> NVidia graphics support to this list. I just want to make
> sure that this hiccup isn't lost:
> 
> Jun  8 15:34:08 styx kernel: Badness in pci_find_subsys at drivers/pci/search.c:167

Please search the archives, this is a well known nvidia driver problem.

Good luck,

greg k-h
