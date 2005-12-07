Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbVLGBcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbVLGBcE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 20:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbVLGBcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 20:32:04 -0500
Received: from mail.suse.de ([195.135.220.2]:12999 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965046AbVLGBcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 20:32:03 -0500
Date: Wed, 7 Dec 2005 02:32:02 +0100
From: Andi Kleen <ak@suse.de>
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH 0/3] x86 PCI domain support
Message-ID: <20051207013201.GZ11190@wotan.suse.de>
References: <20051203013904.GA2560@havoc.gtf.org> <20051203031533.GB14247@wotan.suse.de> <4391FC0A.9040202@pobox.com> <20051207003922.GA18528@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207003922.GA18528@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 04:39:22PM -0800, Greg KH wrote:
> On Sat, Dec 03, 2005 at 03:11:54PM -0500, Jeff Garzik wrote:
> > The first two patches could go in immediately, the last should probably 
> > wait a bit...
> 
> What is the rush?  These seem pretty late for the -rc series :)
> 
> I'll send them in after 2.6.15 is out, is that ok?

It's ok, but the two related workaround patches I posted earlier should
go into .15 (because they fix broken boot on some machines) 

-Andi
