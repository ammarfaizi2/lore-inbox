Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268325AbUIKVDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268325AbUIKVDE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 17:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268326AbUIKVDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 17:03:04 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:62473 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268325AbUIKVCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 17:02:50 -0400
Date: Sat, 11 Sep 2004 22:02:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.9-rc1-mm4 6/6] [m32r] Update CF/PCMCIA drivers
Message-ID: <20040911220242.A4980@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hirokazu Takata <takata@linux-m32r.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040912.052403.730551818.takata@linux-m32r.org> <20040912.055123.719890756.takata@linux-m32r.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040912.055123.719890756.takata@linux-m32r.org>; from takata@linux-m32r.org on Sun, Sep 12, 2004 at 05:51:23AM +0900
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 05:51:23AM +0900, Hirokazu Takata wrote:
> [PATCH 2.6.9-rc1-mm4 6/6] [m32r] Update CF/PCMCIA drivers
>   This patch updates m32r-specific CF/PCMCIA drivers and 
>   fixes compile errors.

Note that these really should be in drivers/pcmcia/

Please also send them to linux-pcmcia@lists.infradead.org for review.
