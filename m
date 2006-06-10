Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751530AbWFJQKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbWFJQKm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 12:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWFJQKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 12:10:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34016 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751530AbWFJQKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 12:10:41 -0400
Date: Sat, 10 Jun 2006 17:10:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       promise_linux@promise.com
Subject: Re: [PATCH] Promise 'stex' driver
Message-ID: <20060610161036.GA21454@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jeff@garzik.org>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	promise_linux@promise.com
References: <20060610160852.GA15316@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060610160852.GA15316@havoc.gtf.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 12:08:52PM -0400, Jeff Garzik wrote:
> 
> Please review, and queue in scsi-misc for 2.6.18 if acceptable.

The driver is not for scsi hardware.  Please implement it as block
driver.

