Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbVGJXIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVGJXIb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 19:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbVGJXFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 19:05:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51152 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262197AbVGJXDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 19:03:51 -0400
Date: Mon, 11 Jul 2005 00:03:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [3/48] Suspend2 2.1.9.8 for 2.6.12: 301-proc-acpi-sleep-activate-hook.patch
Message-ID: <20050710230347.GB513@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nigel Cunningham <nigel@suspend2.net>, linux-kernel@vger.kernel.org
References: <11206164393426@foobar.com> <11206164393081@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11206164393081@foobar.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please add an explanation why this is nessecary.  Big NACK for the patch as-is, but
to find a proper solution we need to know what you're actually doing.

