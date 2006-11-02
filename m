Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752685AbWKBFqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685AbWKBFqU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 00:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752684AbWKBFqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 00:46:20 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:35238 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752680AbWKBFqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 00:46:19 -0500
Message-ID: <45498628.9090105@garzik.org>
Date: Thu, 02 Nov 2006 00:46:16 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: More Promise chipset specs opened
References: <45497E3A.6060103@garzik.org>
In-Reply-To: <45497E3A.6060103@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Promise has given me permission to post hardware programming info for 
> one of their chips (Linux driver: sata_promise), PDC20319.  This also 
> marks the first open chipset for Promise (AFAIK), so let's give them a 
> round of applause.

I missed an email from Promise which supplied even more chipset docs to 
open.  Whoops.  The entire line supported by sata_promise.c should now 
be open:

2037x:
http://gkernel.sourceforge.net/specs/promise/pdc2037x%20series%20development%20guide.pdf.bz2

20319 (updated link, updated doc):
http://gkernel.sourceforge.net/specs/promise/pdc20319%20development%20guide.pdf.bz2

205xx (the newer NCQ chips):
http://gkernel.sourceforge.net/specs/promise/pdc205xx%20development%20guide%201.0.pdf.bz2

Cheers,

	Jeff


