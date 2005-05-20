Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVETKAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVETKAU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 06:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVETKAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 06:00:20 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:8943 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261394AbVETKAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 06:00:14 -0400
Date: Fri, 20 May 2005 15:39:29 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: "K.R. Foley" <kr@cybsft.com>, Andrew Morton <akpm@osdl.org>,
       gregoire.favre@gmail.com, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-ID: <20050520100928.GA3963@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050516085832.GA9558@gmail.com> <20050517071307.GA4794@in.ibm.com> <20050517002908.005a9ba7.akpm@osdl.org> <1116340465.4989.2.camel@mulgrave> <20050517170824.GA3931@in.ibm.com> <1116354894.4989.42.camel@mulgrave> <428C030E.8030102@cybsft.com> <1116476630.5867.2.camel@mulgrave> <20050519095143.GA3972@in.ibm.com> <1116546970.5037.137.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116546970.5037.137.camel@mulgrave>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2005 at 06:56:10PM -0500, James Bottomley wrote:
> 
> OK, could you try this one (also against vanilla 2.6.12-rc4).  Hopefully
> it's a rollup of all the aic7xxx changes plus the necessary supporting
> infrastructure in my scsi-misc tree.
> 

This works fine for me with 2.6.12-rc4, Thanks

I would appreciate if you can send this to -mm too

	-Dinakar
