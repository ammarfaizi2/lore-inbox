Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266490AbUIMKUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266490AbUIMKUm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 06:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266491AbUIMKUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 06:20:42 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:22538 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266490AbUIMKUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 06:20:41 -0400
Date: Mon, 13 Sep 2004 11:20:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5
Message-ID: <20040913112037.A25118@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040913015003.5406abae.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040913015003.5406abae.akpm@osdl.org>; from akpm@osdl.org on Mon, Sep 13, 2004 at 01:50:03AM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +lockmeter.patch
> 
>  Repaired lockmeter patch

This one is still needlessly messing around in procfs internals.

