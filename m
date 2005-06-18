Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbVFROQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbVFROQn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 10:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbVFROQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 10:16:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:52148 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262120AbVFROQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 10:16:41 -0400
Date: Sat, 18 Jun 2005 15:16:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PATCH] SCSI updates for 2.6.12
Message-ID: <20050618141636.GA4112@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1119103586.4984.5.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119103586.4984.5.camel@mulgrave>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrew Vasquez:
>   o qla2xxx: Pull-down scsi-host-addition to follow board initialization

Can we please put this one in 2.6.12.1?  qla2xxx breaks horribly in 2.6.12
because this one is missing.
