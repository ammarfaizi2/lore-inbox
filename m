Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVAMQbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVAMQbx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 11:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVAMQ22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 11:28:28 -0500
Received: from canuck.infradead.org ([205.233.218.70]:61962 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261663AbVAMQUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 11:20:20 -0500
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
From: Arjan van de Ven <arjan@infradead.org>
To: jarausch@belgacom.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050113151050.051BEFEC0E@numa-i.igpm.rwth-aachen.de>
References: <20050113151050.051BEFEC0E@numa-i.igpm.rwth-aachen.de>
Content-Type: text/plain
Date: Thu, 13 Jan 2005 17:19:16 +0100
Message-Id: <1105633157.6031.28.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-10-22 at 20:45 +0200, jarausch@belgacom.net wrote:
> Hello,
> 
> yes I know, you don't like modules without full sources available.
> But Nvidia is the leading vendor of video cards and all 2.4.x
> kernels up to 2.4.13-pre5 work nice with this module.
> 
> Running pre6 I get
> (==) NVIDIA(0): Write-combining range (0xf0000000,0x2000000)
> (EE) NVIDIA(0): Failed to allocate LUT context DMA
> (EE) NVIDIA(0):  *** Aborting ***
> 
> 
> This is Nvidia's 1.0-1541 version of its Linux drivers
> 
> Please keep this driver going during the 2.4.x series of the
> kernel if at all possible.

you're talking to the wrong forum

