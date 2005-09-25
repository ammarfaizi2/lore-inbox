Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbVIYMr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbVIYMr2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 08:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbVIYMr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 08:47:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9135 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751291AbVIYMr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 08:47:27 -0400
Date: Sun, 25 Sep 2005 13:47:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CONFIG_IA32
Message-ID: <20050925124725.GA16878@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Brian Gerst <bgerst@didntduck.org>, Andrew Morton <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <4335DD14.7090909@didntduck.org> <20050925100525.GA14741@infradead.org> <43369ACF.3000102@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43369ACF.3000102@didntduck.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2005 at 08:40:47AM -0400, Brian Gerst wrote:
> I386 is already used elsewhere for cpu optimization.  Intel has called 
> all of its 32-bit cpus IA32 since they introduced IA64.  I've never 
> heard of any usage of X86_32.

Intel doesn't use x86-64 or X86_64 either.  We're not their fifth marketing
bridgade.

