Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTFXSaU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 14:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTFXSaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 14:30:20 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:47520 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262568AbTFXSaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 14:30:17 -0400
Date: Tue, 24 Jun 2003 11:42:48 -0700
From: Greg KH <greg@kroah.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.73 compile error
Message-ID: <20030624184248.GA1458@kroah.com>
References: <20030624163548.GA3914@kroah.com> <Pine.LNX.3.96.1030624141403.6519C-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030624141403.6519C-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 02:15:57PM -0400, Bill Davidsen wrote:
> On Tue, 24 Jun 2003, Greg KH wrote:
> 
> > On Tue, Jun 24, 2003 at 07:36:09AM +0900, Seiichi Nakashima wrote:
> > > Hi.
> > > 
> > > I update to linux-2.5.73 from linux-2.5.72.
> > > compile error occured.
> > 
> > Search the archives for the patch, or just enable CONFIG_HOTPLUG
> 
> Looking at the error posted, it is in hotplug. It may be a silly question,
> but shouldn't whatever makes the hotplug source compile also compile the
> requirements? If CONFIG_HOTPLUG is not selected, why is it compiled?
> 
> In search of consistency...

See the patch for consistency :)

greg k-h
