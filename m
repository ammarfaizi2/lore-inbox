Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVELIji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVELIji (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 04:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVELIji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 04:39:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42691 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261342AbVELIjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 04:39:35 -0400
Date: Thu, 12 May 2005 09:39:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ATM makefile for out-of-source-tree builds
Message-ID: <20050512083933.GA13137@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Beulich <JBeulich@novell.com>, sam@ravnborg.org,
	linux-kernel@vger.kernel.org
References: <s28321ef.089@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s28321ef.089@emea1-mh.id2.novell.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 10:29:35AM +0200, Jan Beulich wrote:
> (Note: Patch also attached because the inline version is certain to get
> line wrapped.)
> 
> Adjust ATM makefile to account for building outside of the source tree.

Btw, if someone still has the hardware it would be really nice to convert
the atm drivers to use the userspace firmware loader.

