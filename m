Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262268AbVAJN5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbVAJN5F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 08:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbVAJN5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 08:57:05 -0500
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:8124 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id S262268AbVAJN4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 08:56:54 -0500
Date: Mon, 10 Jan 2005 14:56:36 +0100 (MET)
From: Peter Daum <gator@cs.tu-berlin.de>
Reply-To: Peter Daum <gator@cs.tu-berlin.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 3ware driver (3w-xxxx) in 2.6.10: procfs entry
In-Reply-To: <20050110132133.GA12360@infradead.org>
Message-ID: <Pine.LNX.4.30.0501101452590.14606-100000@swamp.bayern.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2005, Christoph Hellwig wrote:

> On Mon, Jan 10, 2005 at 02:03:32PM +0100, Peter Daum wrote:
> >
> > It looks like in the 3ware driver the procfs entry "/proc/scsi/3w-xxxx"
> > has been removed (or actually moved to sysfs).
> > Unfortunately, this breaks all the (binary only )-: tools provided by
> > 3ware, which are indispensable for system maintenance.
>
> The change came from the driver maintainer at 3ware.  Get the updated
> tools from their website.

Which website do you mean? The programs in the download section of
"www.3ware.com" are just the ones that don't work anymore.

