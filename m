Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269639AbTHJOzQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 10:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269646AbTHJOzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 10:55:16 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:17412 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269639AbTHJOzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 10:55:11 -0400
Date: Sun, 10 Aug 2003 15:55:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] convert drivers/scsi to virt_to_pageoff()
Message-ID: <20030810155510.C18400@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20030810013041.679ddc4c.davem@redhat.com> <20030810090556.GY31810@waste.org> <20030810020444.48cb740b.davem@redhat.com> <20030810.201009.77128484.yoshfuji@linux-ipv6.org> <20030810123148.A10435@infradead.org> <20030810145511.B32508@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030810145511.B32508@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sun, Aug 10, 2003 at 02:55:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 02:55:11PM +0100, Russell King wrote:
> Actually, I'd rather see Scsi_Pointer gain page + offset (or even better
> a single sg element) and get rid of these conversions.

Patches are welcome...

