Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262607AbVDYNYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbVDYNYD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 09:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbVDYNYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 09:24:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55706 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262607AbVDYNYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 09:24:01 -0400
Date: Mon, 25 Apr 2005 14:23:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 10/12] s390: remove ioctl32 from dasdcmb.
Message-ID: <20050425132358.GA8976@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20050422190527.GA2359@infradead.org> <OF3AF6AFBF.50033D62-ONC1256FEE.00295572-C1256FEE.002A5318@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF3AF6AFBF.50033D62-ONC1256FEE.00295572-C1256FEE.002A5318@de.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 09:42:17AM +0200, Martin Schwidefsky wrote:
> > I don't think that there should be ifdefs for COMPATIBLE_IOCTL entries.
> >
> 
> Then it stand to reason to remove ALL the ifdefs in arch/s390/kernel/compat_ioctl.c

makes sense
