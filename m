Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUFNOov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUFNOov (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 10:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbUFNOov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 10:44:51 -0400
Received: from [213.146.154.40] ([213.146.154.40]:15833 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262389AbUFNOot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 10:44:49 -0400
Date: Mon, 14 Jun 2004 15:44:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] IDE update for 2.6.7-rc3 [1/12]
Message-ID: <20040614144448.GA21851@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	greg@kroah.com
References: <200406111750.30312.bzolnier@elka.pw.edu.pl> <200406131936.08338.bzolnier@elka.pw.edu.pl> <20040614095835.GA11585@infradead.org> <200406141636.01353.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406141636.01353.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 04:36:01PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Are you sure?  I've seen piix3/4 in very strange place, iirc even in
> > a docking station which is hotpluggable.
> 
> Do you mean that south-bridge chipset itself is hotpluggable?
> 
> AFAIK it is only ATA hotplug not PCI one.

that thingy had an ide controller that was hotpluggable in the dockingstation.
And IIRC it was a piix4 with everything but ide and superio disabled.

