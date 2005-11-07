Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbVKGDZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbVKGDZW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVKGDZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:25:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37566 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932438AbVKGDZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:25:19 -0500
Date: Mon, 7 Nov 2005 03:25:18 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm1
Message-ID: <20051107032518.GA12192@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20051106182447.5f571a46.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051106182447.5f571a46.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +add-be-le-types-without-underscores.patch
> 
>  cleanup

please don't.  having two types for exacytly the same thing is always a
bad idea.

