Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVBFPu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVBFPu2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 10:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVBFPu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 10:50:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60076 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261159AbVBFPuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 10:50:24 -0500
Date: Sun, 6 Feb 2005 15:50:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Martins Krikis <mkrikis@yahoo.com>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [ANNOUNCE] "iswraid" (ICHxR ataraid sub-driver) for 2.4.29
Message-ID: <20050206155017.GA1215@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Martins Krikis <mkrikis@yahoo.com>, marcelo.tosatti@cyclades.com,
	linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
References: <87651hdoiv.fsf@yahoo.com> <420582C6.7060407@pobox.com> <1107682076.22680.58.camel@laptopd505.fenrus.org> <58cb370e050206044513eb7f89@mail.gmail.com> <42062BFE.7070907@pobox.com> <1107701373.22680.115.camel@laptopd505.fenrus.org> <420631BF.7060407@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420631BF.7060407@pobox.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 10:03:27AM -0500, Jeff Garzik wrote:
> Red herring.
> 
> 2.4.x has ICH5/6 support -- but is missing the RAID support component.
> 
> We are talking about hardware that is ALREADY supported by 2.4.x kernel, 
> not new hardware.

You're talking about software not support (the intel bios fakeraid format).

