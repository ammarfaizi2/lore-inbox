Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268435AbUIFShW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268435AbUIFShW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 14:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268458AbUIFShV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 14:37:21 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:9479 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268435AbUIFSgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 14:36:42 -0400
Date: Mon, 6 Sep 2004 19:36:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: blaisorblade_spam@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 1/1] uml: no extraversion in arch/um/Makefile for mainline
Message-ID: <20040906193620.A8502@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	blaisorblade_spam@yahoo.it, akpm@osdl.org, jdike@addtoit.com,
	linux-kernel@vger.kernel.org,
	user-mode-linux-devel@lists.sourceforge.net
References: <20040906173524.EE034B977@zion.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040906173524.EE034B977@zion.localdomain>; from blaisorblade_spam@yahoo.it on Mon, Sep 06, 2004 at 07:35:24PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could you please fix UML to not use ghash.h and remove that one before
playing with new toys?  This has been requested a few times now.

