Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVAMXZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVAMXZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 18:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVAMXWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 18:22:18 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:65186 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261774AbVAMXUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 18:20:35 -0500
Date: Thu, 13 Jan 2005 13:32:51 -0800
From: Greg KH <greg@kroah.com>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: add Ever UPS vendor/product id to ftdi_sio driver
Message-ID: <20050113213251.GB31723@kroah.com>
References: <200501132014.34558.arekm@pld-linux.org> <200501132030.33996.arekm@pld-linux.org> <20050113193403.GA29645@kroah.com> <200501132049.29969.arekm@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501132049.29969.arekm@pld-linux.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 08:49:29PM +0100, Arkadiusz Miskiewicz wrote:
> On Thursday 13 of January 2005 20:34, Greg KH wrote:
> 
> > But you lost the description of the patch and the Signed-off-by: line :(
> > Third time's a charm.
> Copy from first mail?
> 
> Ok, here it goes once again with description everywhere.
> 
> This patch allows to use ftdi_sio driver with Ever ECO Pro CDS UPS.
> Patch was tested on pre-2.6.10 kernel.
> 
> Signed-Off: Arkadiusz Miskiewicz <arekm@pld-linux.org>

Next time can you create the patch so I can apply it with -p1 on the
patch command line.  I fixed up this one already.

Applied, thanks.

greg k-h
