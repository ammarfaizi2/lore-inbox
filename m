Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264883AbTLKLMr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 06:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbTLKLMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 06:12:47 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:27150 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264883AbTLKLMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 06:12:46 -0500
Date: Thu, 11 Dec 2003 11:12:41 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Tomas Martisius <tomas@puga.vdu.lt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: AMD 53c974 SCSI driver in 2.6
Message-ID: <20031211111241.A16644@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tomas Martisius <tomas@puga.vdu.lt>, linux-kernel@vger.kernel.org
References: <3FD8325C.5080701@puga.vdu.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FD8325C.5080701@puga.vdu.lt>; from tomas@puga.vdu.lt on Thu, Dec 11, 2003 at 11:01:16AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 11:01:16AM +0200, Tomas Martisius wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello,
> 
> On Sun, 26 Oct 2003, Guennadi Liakhovetski posted patch for
> AM53c974 driver. May be it is not perfect, but it is still not applied
> to kernel source. I think it is better to have at least not broken
> driver compared with existing.
> I have Compaq deskpro XL 590 PC with integrated such controler, and this
> driver affter applinig Guennadi Liakhovetski pach to 2.6.0-test11 source
> works for me.

The patch is broken but he has a better patch for the other driver for
that hardware, that will hopefully go into 2.6.1.

