Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbUKDL5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbUKDL5k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 06:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbUKDLzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 06:55:21 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:9480 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262170AbUKDLla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 06:41:30 -0500
Date: Thu, 4 Nov 2004 11:41:26 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 7/12] meye: the driver is no longer experimental and depends on PCI
Message-ID: <20041104114126.GA31736@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <20041104111231.GF3472@crusoe.alcove-fr> <20041104111613.GM3472@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104111613.GM3472@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	depends on VIDEO_DEV && PCI && SONYPI && !HIGHMEM64G

What's the problem with PAE?
