Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbTDYN2S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 09:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263139AbTDYN2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 09:28:18 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:9995 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263075AbTDYN2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 09:28:17 -0400
Date: Fri, 25 Apr 2003 14:40:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aha1740 update, take #2
Message-ID: <20030425144026.A747@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marc Zyngier <mzyngier@freesurf.fr>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <wrpk7dkt84r.fsf@hina.wild-wind.fr.eu.org> <20030424133641.A29770@infradead.org> <wrp1xzqsoas.fsf_-_@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <wrp1xzqsoas.fsf_-_@hina.wild-wind.fr.eu.org>; from mzyngier@freesurf.fr on Fri, Apr 25, 2003 at 03:24:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 25, 2003 at 03:24:11PM +0200, Marc Zyngier wrote:
> Alan, Christoph,
> 
> Here is the updated aha1740 driver. All remarks have been taken into
> account (patch is quite huge because of the re-indentation).
> 
> I removed the the scsi_to_dma_dir part, and sent it over to James (you
> still need it though, see my previous mail to LKML for the patch).

Btw, scsi driver updates usually go to linux-scsi@vger, James then picks
them up into the scsi BK tree that Linus pulls from time to time.

And well, the indentation is Alan-stule not Linux-style but the driver
looks fine.

