Return-Path: <linux-kernel-owner+w=401wt.eu-S964902AbXAJPPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbXAJPPz (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 10:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbXAJPPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 10:15:55 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:47259 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964902AbXAJPPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 10:15:55 -0500
Date: Wed, 10 Jan 2007 10:15:54 -0500
To: Jeff Garzik <jeff@garzik.org>
Cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: SATA/IDE Dual Mode w/Intel 945 Chipset or HOW TO LIQUIFY a flash IDE chip under 2.6.18
Message-ID: <20070110151554.GK17267@csclub.uwaterloo.ca>
References: <45A3FF32.1030905@wolfmountaingroup.com> <45A42385.7090904@garzik.org> <45A42670.703@wolfmountaingroup.com> <45A4325C.9060902@garzik.org> <20070110143919.GH17269@csclub.uwaterloo.ca> <45A4FF0D.2090705@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A4FF0D.2090705@garzik.org>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2007 at 09:58:21AM -0500, Jeff Garzik wrote:
> Enhanced mode means separate SATA and PATA.
> 
> (I recommend avoiding the "IDE" acronym, it is largely meaningless and 
> confusing these days)

Good idea.

> We're talking about Linux here.  Linux regularly supports hardware 
> before Windows does.  This is nothing new.

That is certainly true.  I just found it odd that intel wouldn't have an
ahci driver available.  But then again if ahci is standard I guess they
would expect microsoft to provide the driver instead, which they
probably aren't doing until vista.  Linux always seems so much easier.
:)  The drivers are just included for everything.

--
Len Sorensen
