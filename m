Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264040AbVBFJ2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264040AbVBFJ2z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 04:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbVBFJ2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 04:28:55 -0500
Received: from canuck.infradead.org ([205.233.218.70]:22802 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S272799AbVBFJ2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 04:28:09 -0500
Subject: Re: [ANNOUNCE] "iswraid" (ICHxR ataraid sub-driver) for 2.4.29
From: Arjan van de Ven <arjan@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Martins Krikis <mkrikis@yahoo.com>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       bzolnier@gmail.com
In-Reply-To: <420582C6.7060407@pobox.com>
References: <87651hdoiv.fsf@yahoo.com>  <420582C6.7060407@pobox.com>
Content-Type: text/plain
Date: Sun, 06 Feb 2005 10:27:56 +0100
Message-Id: <1107682076.22680.58.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.3 (/)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (0.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-02-05 at 21:36 -0500, Jeff Garzik wrote:
> Martins Krikis wrote:
> > Version 0.1.5 of the Intel Sofware RAID driver (iswraid) is now
> > available for the 2.4 series kernels at
> > http://prdownloads.sourceforge.net/iswraid/2.4.29-iswraid.patch.gz?download
> 
> ACK from me

 personally I consider it a new feature, and I don't consider new
features like this appropriate for a 2.4 deep maintenance stream.


