Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbUKEX2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbUKEX2V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 18:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbUKEX0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 18:26:33 -0500
Received: from mail.kroah.org ([69.55.234.183]:16081 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261258AbUKEXRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 18:17:01 -0500
Date: Fri, 5 Nov 2004 15:10:42 -0800
From: Greg KH <greg@kroah.com>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.9-mm1, kernel Ooops in visor_open
Message-ID: <20041105231042.GA31224@kroah.com>
References: <20041025144846.GA2137@gamma.logic.tuwien.ac.at> <20041026044351.GA12453@kroah.com> <20041102063836.GA11777@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041102063836.GA11777@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 07:38:36AM +0100, Norbert Preining wrote:
> Hi Greg!
> 
> On Mon, 25 Okt 2004, Greg KH wrote:
> > > 	linux-2.6.9-mm1
> > > 	debian/sid
> > > I get the following kernel warning:
> > 
> > Crud, you aren't the only one reporting this...  I'll test this out with
> > my visor later tomorrow and look into it.
> 
> Did you find anything related to this Oops? Do you have a fix for it?

I can't get my visor to work at all, it's a very old one (first
generation.)  I'm going to need some debugging help from others here...

thanks,

greg k-h
