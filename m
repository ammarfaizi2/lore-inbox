Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267091AbSKMB0W>; Tue, 12 Nov 2002 20:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267089AbSKMB0W>; Tue, 12 Nov 2002 20:26:22 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:46603 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267086AbSKMB0U>; Tue, 12 Nov 2002 20:26:20 -0500
Date: Wed, 13 Nov 2002 01:33:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Mukker, Atul" <atulm@lsil.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] MegaRAID RAID driver version 2.00 - introduced as new megaraid2 in 2.4.x and 2.5.x
Message-ID: <20021113013310.A2830@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Mukker, Atul" <atulm@lsil.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <0E3FA95632D6D047BA649F95DAB60E570185ED7B@EXA-ATLANTA.se.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570185ED7B@EXA-ATLANTA.se.lsil.com>; from atulm@lsil.com on Tue, Nov 12, 2002 at 08:24:57PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[could you cut down the Cc list to something reasonable next time?]

On Tue, Nov 12, 2002 at 08:24:57PM -0500, Mukker, Atul wrote:
> Alan et al,
> 
> Attached please find the megaraid driver version 2.00, which is to be
> introduced as megaraid2 in 2.4.x and 2.5.x kernels. The mail has two
> attachments:
> 1.	megaraid v200 for 2.4.x kernels - megaraid2-v200.tar.gz
> 2.	patch for 2.5.x kernels - megaraid2-v200-24x-25x.patch.gz
> 
> Other people on linux lists: Driver is not attached for lists. Please await
> announcement from Matt Domsch after he has updated the appropriate download
> sites.

Please don't add another driver.  From what I've seen the megaraid2
is nothing but the bugfixes/partial rewrite RH did for their Advanced
Server.  Just add it to 2.5 and maybe 2.4-ac instead of the current driver,
if it proves stable it can go into 2.4 later.

