Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVDCQkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVDCQkz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 12:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVDCQkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 12:40:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24248 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261798AbVDCQkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 12:40:51 -0400
Date: Sun, 3 Apr 2005 17:40:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: kaos@ocs.com.au, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RCU in kernel/intermodule.c
Message-ID: <20050403164041.GA28827@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Luca Falavigna <dktrkranz@gmail.com>, kaos@ocs.com.au,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <424E81CC.6000600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424E81CC.6000600@gmail.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2005 at 11:28:12AM +0000, Luca Falavigna wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> This patch, compiled against version 2.6.12-rc1, implements RCU mechanism in
> intermodule functions.

There's no point as these functions are going to go away soon.

