Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbTJXO71 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 10:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbTJXO71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 10:59:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21889 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262253AbTJXO7Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 10:59:25 -0400
Date: Fri, 24 Oct 2003 15:59:24 +0100
From: Matthew Wilcox <willy@debian.org>
To: "Moore, Eric Dean" <emoore@lsil.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  2.4.23-pre8 driver udpate for MPT Fusion (2.05.10)
Message-ID: <20031024145924.GU18370@parcelfarce.linux.theplanet.co.uk>
References: <0E3FA95632D6D047BA649F95DAB60E57035A944F@exa-atlanta.se.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57035A944F@exa-atlanta.se.lsil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 24, 2003 at 10:53:59AM -0400, Moore, Eric Dean wrote:
> Here's a patch for 2.4.23-pre8 kernel for MPT Fusion driver, coming from LSI
> Logic.

Are we going to see an update for 2.6 soon, and will it include support
for hotplugging the fusion card from the pci bus (ie conversion to the
"new" PCI API)?

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
