Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbVKLOfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbVKLOfY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 09:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbVKLOfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 09:35:24 -0500
Received: from smtp4.brturbo.com.br ([200.199.201.180]:4729 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932387AbVKLOfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 09:35:23 -0500
Subject: Re: [PATCH 09/25] v4l: move ioctl32 handlers to drivers/media/
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
In-Reply-To: <200511071117.50613.arnd@arndb.de>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
	 <20051105162714.261619000@b551138y.boeblingen.de.ibm.com>
	 <1131250426.19680.29.camel@localhost>  <200511071117.50613.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 12 Nov 2005 12:35:04 -0200
Message-Id: <1131806104.6504.38.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd,

	We've applied on V4L CVS. There are some fixes for it to work as
expected. We are currently working on it. I intend to submit all stuff
after the fixes.

Cheers,
Mauro.

Em Seg, 2005-11-07 às 11:17 +0100, Arnd Bergmann escreveu:
> On Sünndag 06 November 2005 05:13, Mauro Carvalho Chehab wrote:
> > Em Sáb, 2005-11-05 às 17:26 +0100, Arnd Bergmann escreveu:
> > > anexo Documento somente texto (compat_vidio.diff)
> > > This moves the 32 bit ioctl compatibility handlers for
> > > Video4Linux into a new file and adds explicit calls to them
> > > to each v4l device driver.
> > 
> > 	Thanks for your patch, but IMHO, it should't be applied on mainstream.
> > It would be better if we apply it on V4L tree and do some work on it to
> > improve handling the compat stuff.
> 
> Sure, that sounds reasonable.
> 


