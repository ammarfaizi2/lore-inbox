Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbUASU4h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 15:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbUASU4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 15:56:37 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:38414 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263637AbUASU4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 15:56:36 -0500
Date: Mon, 19 Jan 2004 20:56:29 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Santiago Leon <santil@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] IBM PowerPC Virtual Ethernet Driver
Message-ID: <20040119205629.A5831@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Santiago Leon <santil@us.ibm.com>, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com
References: <400C3CEA.1060004@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <400C3CEA.1060004@us.ibm.com>; from santil@us.ibm.com on Mon, Jan 19, 2004 at 03:24:10PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 03:24:10PM -0500, Santiago Leon wrote:
> Here's a patch that adds the inter-partition Virtual Ethernet driver for 
> newer IBM iSeries and pSeries systems:
> 
> http://www-124.ibm.com/linux/patches/ppc64/ibmveth.patch
> 
> The patch applies against the 2.4.25-pre6 tree...

Usually patches are subitted inline to ease review..

> Jeff, can you formally add this driver to 2.4?... I'm waiting for some
> ppc64 architectural addition to send out the driver for 2.6...

I think we shouldn't accept new drivers in 2.4 anymore unless they're
already in 2.6
