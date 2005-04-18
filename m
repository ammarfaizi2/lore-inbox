Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbVDRPmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbVDRPmh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 11:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVDRPmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 11:42:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9943 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261401AbVDRPma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 11:42:30 -0400
Date: Mon, 18 Apr 2005 16:42:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: mike.miller@hp.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       marcelo.tosatti@cyclades.com
Subject: Re: [RFC 1 of 9] patches to add diskdump functionality to block layer
Message-ID: <20050418154226.GA26503@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, mike.miller@hp.com,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	marcelo.tosatti@cyclades.com
References: <20050418153644.GA25409@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050418153644.GA25409@beardog.cca.cpqcorp.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks like a patch for Linux 2.4.  Such major changes for the
2.4 tree don't make sense anymore, especially for functionality not
even in Linux 2.6.

