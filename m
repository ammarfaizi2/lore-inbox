Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVB1DVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVB1DVF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 22:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVB1DVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 22:21:05 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33501 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261539AbVB1DVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 22:21:03 -0500
Date: Mon, 28 Feb 2005 03:21:01 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Wen Xiong <wendyx@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [ patch 4/7] drivers/serial/jsm: new serial device driver
Message-ID: <20050228032101.GA5300@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Wen Xiong <wendyx@us.ibm.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
References: <42225A47.3060206@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42225A47.3060206@us.ltcfwd.linux.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2005 at 06:39:51PM -0500, Wen Xiong wrote:
> This patch is for jsm_proc.c and includes the functions relating to 
> /proc/jsm entry.

please don't put in more procfs driver interfaces.
