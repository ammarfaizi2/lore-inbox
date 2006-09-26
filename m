Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWIZQLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWIZQLf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 12:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWIZQLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 12:11:35 -0400
Received: from mail.sanpeople.com ([196.41.13.122]:14852 "EHLO
	za-gw.sanpeople.com") by vger.kernel.org with ESMTP id S932335AbWIZQLe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 12:11:34 -0400
Subject: Re: [PATCH 0/3] at91_serial: Introduction
From: Andrew Victor <andrew@sanpeople.com>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20060926114826.3f85b939@cad-250-152.norway.atmel.com>
References: <11545303083273-git-send-email-hskinnemoen@atmel.com>
	 <20060923211417.GB4363@flint.arm.linux.org.uk>
	 <1159261584.24659.16.camel@fuzzie.sanpeople.com>
	 <20060926112757.03dd8cbc@cad-250-152.norway.atmel.com>
	 <1159262891.24662.25.camel@fuzzie.sanpeople.com>
	 <20060926114826.3f85b939@cad-250-152.norway.atmel.com>
Content-Type: text/plain
Organization: Multenet Technologies (Pty) Ltd
Message-Id: <1159286614.24889.180.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 26 Sep 2006 18:03:34 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Haavard,

> > I don't think the DMA-support is currently in mainline, but is in the
> > pending patches on http://maxim.org.za/AT91RM9200/2.6/
> 
> Are you going to submit it for 2.6.19? I want to try to slam a big
> rename patch in without messing up too many not-yet-submitted patches...

I was intending to, but Chip Coldwell hasn't gotten back to me yet about
some problems that were reported with the DMA support.

So I guess now would be as good a time as any to rename the serial
driver.


Regards, 
  Andrew Victor


