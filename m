Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262237AbVAJNVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbVAJNVi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 08:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbVAJNVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 08:21:38 -0500
Received: from [213.146.154.40] ([213.146.154.40]:6634 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262237AbVAJNVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 08:21:34 -0500
Date: Mon, 10 Jan 2005 13:21:33 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Peter Daum <gator@cs.tu-berlin.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3ware driver (3w-xxxx) in 2.6.10: procfs entry
Message-ID: <20050110132133.GA12360@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Peter Daum <gator@cs.tu-berlin.de>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.30.0501101348430.13619-100000@swamp.bayern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0501101348430.13619-100000@swamp.bayern.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 02:03:32PM +0100, Peter Daum wrote:
> 
> It looks like in the 3ware driver the procfs entry "/proc/scsi/3w-xxxx"
> has been removed (or actually moved to sysfs).
> Unfortunately, this breaks all the (binary only )-: tools provided by
> 3ware, which are indispensable for system maintenance.

The change came from the driver maintainer at 3ware.  Get the updated
tools from their website.

