Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbTJYUoL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 16:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbTJYUoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 16:44:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21199 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262792AbTJYUoJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 16:44:09 -0400
Date: Sat, 25 Oct 2003 21:44:05 +0100
From: Matthew Wilcox <willy@debian.org>
To: Greg KH <greg@kroah.com>
Cc: "Moore, Eric Dean" <emoore@lsil.com>, Matthew Wilcox <willy@debian.org>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  2.4.23-pre8 driver udpate for MPT Fusion (2.05.10)
Message-ID: <20031025204405.GB5172@parcelfarce.linux.theplanet.co.uk>
References: <0E3FA95632D6D047BA649F95DAB60E57035A9458@exa-atlanta.se.lsil.com> <20031025191828.GA17144@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031025191828.GA17144@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 25, 2003 at 12:18:28PM -0700, Greg KH wrote:
> On Fri, Oct 24, 2003 at 11:12:25AM -0400, Moore, Eric Dean wrote:
> > I'm going to be working on that.
> > Can't say when its going to be ready.
> 
> How about support for all of the pci hotplug systems on 2.4 that are
> shipping today? 

The SCSI system isn't really capable of supporting hotplug PCI in 2.4.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
