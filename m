Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUFVI7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUFVI7Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 04:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUFVI7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 04:59:25 -0400
Received: from [213.146.154.40] ([213.146.154.40]:11394 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261830AbUFVI7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 04:59:06 -0400
Date: Tue, 22 Jun 2004 09:59:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core
Message-ID: <20040622085901.GA31971@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Mikael Pettersson <mikpe@csd.uu.se>,
	linux-kernel@vger.kernel.org
References: <200405312218.i4VMIISg012277@harpo.it.uu.se> <20040622015311.561a73bf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040622015311.561a73bf.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 01:53:11AM -0700, Andrew Morton wrote:
> Also there should be a document or a manpage or something which describes,
> in detail:
> 
> - the user/kernel API  (separate document, probably)

It also needs moving back to /proc/<pid>/ files from the syscall API.

