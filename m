Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264654AbTBNSCO>; Fri, 14 Feb 2003 13:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264681AbTBNSCO>; Fri, 14 Feb 2003 13:02:14 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:43012 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264654AbTBNSCN>; Fri, 14 Feb 2003 13:02:13 -0500
Date: Fri, 14 Feb 2003 18:12:03 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EISA/sysfs update
Message-ID: <20030214181203.A32737@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marc Zyngier <mzyngier@freesurf.fr>,
	James Bottomley <James.Bottomley@steeleye.com>,
	linux-kernel@vger.kernel.org
References: <1044241767.3924.14.camel@mulgrave> <wrp3cmrrwuf.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <wrp3cmrrwuf.fsf@hina.wild-wind.fr.eu.org>; from mzyngier@freesurf.fr on Fri, Feb 14, 2003 at 11:16:24AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 11:16:24AM +0100, Marc Zyngier wrote:
> James, LKML,
> 
> Here is the latest round of EISA/sysfs hacking.

BTW, could you fix eisa_driver_register to properly return 0 on
sucess instead of 1?

