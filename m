Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262576AbVFJPlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbVFJPlz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 11:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbVFJPkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 11:40:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51161 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262576AbVFJPfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 11:35:10 -0400
Date: Fri, 10 Jun 2005 16:35:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: li nux <lnxluv@yahoo.com>
Cc: linux <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: problem with module tainting the kernel
Message-ID: <20050610153506.GA8118@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	li nux <lnxluv@yahoo.com>, linux <linux-kernel@vger.kernel.org>
References: <20050610152450.82261.qmail@web33315.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050610152450.82261.qmail@web33315.mail.mud.yahoo.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 08:24:50AM -0700, li nux wrote:
> In 2.6 kernels how to assure that on inserting our own
> module, it doesn't throw the warning:
> 
> "unsupported module, tainting kernel"

There's no place in the kernel that produces this message.  Are you
using some odd vendor tree?

