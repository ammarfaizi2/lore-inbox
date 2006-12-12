Return-Path: <linux-kernel-owner+w=401wt.eu-S1751016AbWLLJo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWLLJo3 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 04:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWLLJo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 04:44:29 -0500
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:25504 "EHLO
	mtagate1.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbWLLJo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 04:44:28 -0500
Date: Tue, 12 Dec 2006 11:44:21 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Joscha Ihl <joscha@grundfarm.de>
Cc: linux-kernel@vger.kernel.org, ihl@fh-brandenburg.de
Subject: Re: Nokia E61 and the kernel BUG at mm/slab.c:594
Message-ID: <20061212094421.GC2818@rhun.haifa.ibm.com>
References: <20061211173506.5c8cb479@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061211173506.5c8cb479@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 05:35:06PM +0100, Joscha Ihl wrote:

> Hi,
> 
> I am using the Nokia E61 phone on my Fujitsu Siemens Amilo D Celeron
> 2.8GHz Notebook as an USB-Modem (cdc_acm 2-1:1.10: ttyACM0: USB ACM
> device) to connect over UMTS to the internet.
> 
> If I plug the USB-cable in the Notebook the system will freeze or I
> only get the following message:

[snip]

> I also tested this with the kernel 2.6.19 without SMP -> the same
> effect, only the message was different:

I assume the previous crash was 2.6.19 with SMP? did it work with
earlier kernels?

I have a Nokia E61, I'll try to reproduce it when I'll have a few free
moments.

Cheers,
Muli
