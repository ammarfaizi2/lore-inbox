Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbWGBHix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWGBHix (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 03:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWGBHix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 03:38:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45025 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751057AbWGBHix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 03:38:53 -0400
Subject: Re: [2.6 patch] EXPORT_UNUSED_SYMBOL{,GPL}
	{,un}register_die_notifier
From: Arjan van de Ven <arjan@infradead.org>
To: Keith Owens <kaos@sgi.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3662.1151820545@ocs3.ocs.com.au>
References: <3662.1151820545@ocs3.ocs.com.au>
Content-Type: text/plain
Date: Sun, 02 Jul 2006 09:38:46 +0200
Message-Id: <1151825926.3111.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-02 at 16:09 +1000, Keith Owens wrote:
> Adrian Bunk (on Fri, 30 Jun 2006 13:33:17 +0200) wrote:
> >This patch marks {,un}register_die_notifier as 
> >EXPORT_UNUSED_SYMBOL{,GPL}.
> 
> KDB needs that.

is kdb is strict module or does it need extra patches anyway?

