Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWICVAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWICVAS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 17:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWICVAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 17:00:18 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:25319 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932136AbWICVAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 17:00:16 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Indan Zupancic" <indan@nul.nu>
Subject: Re: Q: Suspend/resume support for sata_sil
Date: Sun, 3 Sep 2006 23:03:28 +0200
User-Agent: KMail/1.9.1
Cc: "Jeff Garzik" <jeff@garzik.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "LKML" <linux-kernel@vger.kernel.org>
References: <200609031251.23743.rjw@sisk.pl> <4947.81.207.0.53.1157292958.squirrel@81.207.0.53>
In-Reply-To: <4947.81.207.0.53.1157292958.squirrel@81.207.0.53>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609032303.29146.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 3 September 2006 16:15, Indan Zupancic wrote:
> On Sun, September 3, 2006 12:51, Rafael J. Wysocki said:
> > Hi,
> >
> > Could you please tell me if suspend/resume is supported by the sata_sil driver?
> 
> Works for me with suspend to ram, and there seem to be plenty suspend/resume functions in
> drivers/scsi/sata_sil.c, so I guess it is.

Thanks.

I'm having a problem with suspending it on HPC nx6325, but I'll need to
investigate it a bit more.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

-- 
VGER BF report: H 3.24176e-08
