Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUDSRFc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 13:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUDSRFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 13:05:32 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:21009 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261576AbUDSRF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 13:05:26 -0400
Date: Mon, 19 Apr 2004 18:05:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, zwane@linuxpower.ca
Subject: Re: [PATCH] floppy98.c: use kernel min/max
Message-ID: <20040419180522.A14468@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	"Randy.Dunlap" <rddunlap@osdl.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, zwane@linuxpower.ca
References: <20040418194357.4cd02a06.rddunlap@osdl.org> <200404191414.15702.bzolnier@elka.pw.edu.pl> <20040419085116.1d8576a6.rddunlap@osdl.org> <200404191859.29846.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200404191859.29846.bzolnier@elka.pw.edu.pl>; from B.Zolnierkiewicz@elka.pw.edu.pl on Mon, Apr 19, 2004 at 06:59:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 06:59:29PM +0200, Bartlomiej Zolnierkiewicz wrote:
> BTW at least PC9800 IDE support needs reworking - it is one BIG hack

Please just kill it then.  PC9800 wasn't completly merged ever and there
haven't been atempts for ages.  No need to stall development because of it.

