Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965059AbVHSTTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbVHSTTL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 15:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbVHSTTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 15:19:11 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:43786 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S965051AbVHSTTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 15:19:10 -0400
Date: Fri, 19 Aug 2005 15:19:04 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [patch] libata passthrough - return register data from HDIO_* commands
Message-ID: <20050819191902.GC2736@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <42FE2FBA.3000605@dresco.co.uk> <430112F6.3090906@dresco.co.uk> <20050819190625.GB2736@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050819190625.GB2736@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 03:06:27PM -0400, John W. Linville wrote:
> On Mon, Aug 15, 2005 at 11:11:02PM +0100, Jon Escombe wrote:
> > 
> > >Here is a first attempt at a patch to return register data from the 
> > >libata passthrough HDIO ioctl handlers, I needed this as the ATA 
> > >'unload immediate' command returns the success in the lbal register. 

> Overall, I like the patch.  I trust your assertion that it actually
> works... :-)
> 
> I have a few comments...

Well, apparently "Jon Escombe <lists@dresco.co.uk>" is not a good
address.  I got a delivery failur notification email from his mail
server.  Hopefully Jon reads the lists... :-)

John
-- 
John W. Linville
linville@tuxdriver.com
