Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWHIRLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWHIRLb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 13:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWHIRLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 13:11:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24279 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751151AbWHIRLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 13:11:30 -0400
Date: Wed, 9 Aug 2006 18:11:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 4/6] r/o bind mount prepwork: inc_nlink() helper
Message-ID: <20060809171127.GD7324@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Hansen <haveblue@us.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060809165729.FE36B262@localhost.localdomain> <20060809165732.F7BDE416@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809165732.F7BDE416@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 09:57:32AM -0700, Dave Hansen wrote:
> 
> This is mostly included for parity with dec_nlink(), where
> we will have some more hooks.  This one should stay pretty
> darn straightforward for now.

Acked-by: Christoph Hellwig <hch@lst.de>

