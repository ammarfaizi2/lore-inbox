Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbULBL1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbULBL1S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 06:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbULBL1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 06:27:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56011 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261589AbULBL1O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 06:27:14 -0500
Message-ID: <41AEFC02.3070309@pobox.com>
Date: Thu, 02 Dec 2004 06:26:58 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Adrian Bunk <bunk@stusta.de>, davem@redhat.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove dp83840.h
References: <20041129111943.GB9722@stusta.de> <20041129113613.GA2718@linux-mips.org>
In-Reply-To: <20041129113613.GA2718@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle wrote:
> On Mon, Nov 29, 2004 at 12:19:43PM +0100, Adrian Bunk wrote:
> 
> 
>>dp83840.h is included once but none of the definitions it contains is 
>>actually used.
>>
>>Is the patch below to remove it OK, or is there any usage planned?
> 
> 
> I would suggest to keep the file as documentation of the DP83840.

that's what the kernel archives are for ;-)

A while back I used google to find 
http://gkernel.sourceforge.net/specs/national_semi/DP83840A.pdf.bz2

	Jeff



