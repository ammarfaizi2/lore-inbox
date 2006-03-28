Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWC1Pmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWC1Pmr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 10:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWC1Pmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 10:42:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58806 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751119AbWC1Pmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 10:42:47 -0500
Date: Tue, 28 Mar 2006 16:42:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm2
Message-ID: <20060328154246.GA18266@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060328003508.2b79c050.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060328003508.2b79c050.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +make-tty_insert_flip_char-a-non-gpl-export.patch

the argumentation is wrong.  the previous code beein inline made drivers
using it even more of a derived work than a _GPL export.  

