Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264725AbUFWOKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264725AbUFWOKd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 10:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265135AbUFWOKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 10:10:33 -0400
Received: from [213.146.154.40] ([213.146.154.40]:10135 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264725AbUFWOKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 10:10:30 -0400
Date: Wed, 23 Jun 2004 15:10:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Kristian =?iso-8859-1?Q?S=F8rensen?= <ks@cs.auc.dk>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why dentry->d_qstr change in 2.6.7 ?
Message-ID: <20040623141027.GA23278@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kristian =?iso-8859-1?Q?S=F8rensen?= <ks@cs.auc.dk>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1087660293.30405.47.camel@localhost> <1087999469.10863.0.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1087999469.10863.0.camel@localhost>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 04:04:29PM +0200, Kristian Sørensen wrote:
> Can it really be, that noone knows why this change has been made !??

There's certainly people who know.  Look into the changelog to read
what they have to say.

