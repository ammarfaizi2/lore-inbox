Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932580AbVLQNQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbVLQNQv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 08:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbVLQNQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 08:16:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37786 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932580AbVLQNQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 08:16:50 -0500
Date: Sat, 17 Dec 2005 13:16:49 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 03/13]  [RFC] ipath copy routines
Message-ID: <20051217131649.GC13043@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
	openib-general@openib.org
References: <200512161548.HbgfRzF2TysjsR2G@cisco.com> <200512161548.lRw6KI369ooIXS9o@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512161548.lRw6KI369ooIXS9o@cisco.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 03:48:54PM -0800, Roland Dreier wrote:
> Copy routines for ipath driver

NACK, assembler copy routines don't belong into drivers.

