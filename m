Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVETBeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVETBeW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 21:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVETBeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 21:34:22 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:13519 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261249AbVETBeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 21:34:14 -0400
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "K.R. Foley" <kr@cybsft.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>, gregoire.favre@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <428D3E1C.2020802@cybsft.com>
References: <20050516085832.GA9558@gmail.com>
	 <20050517071307.GA4794@in.ibm.com> <20050517002908.005a9ba7.akpm@osdl.org>
	 <1116340465.4989.2.camel@mulgrave> <20050517170824.GA3931@in.ibm.com>
	 <1116354894.4989.42.camel@mulgrave> <428C030E.8030102@cybsft.com>
	 <1116476630.5867.2.camel@mulgrave>  <20050519095143.GA3972@in.ibm.com>
	 <1116546970.5037.137.camel@mulgrave>  <428D37CF.5070903@cybsft.com>
	 <1116551853.5037.145.camel@mulgrave>  <428D3E1C.2020802@cybsft.com>
Content-Type: text/plain
Date: Thu, 19 May 2005 20:33:56 -0500
Message-Id: <1116552836.5037.152.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 20:32 -0500, K.R. Foley wrote:
> > cat /sys/class/spi_transport/target0:0:0/max_period
> 
> this doesn't exist, but i bet you knew that

Doh, sorry, brain malfunction.  That should be min_period ...

James


