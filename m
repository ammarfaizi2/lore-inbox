Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754261AbWKMIEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261AbWKMIEQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 03:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754263AbWKMIEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 03:04:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23979 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1754252AbWKMIEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 03:04:15 -0500
Subject: Re: [PATCH] implement-system-call-mini-HOWTO.txt
From: Arjan van de Ven <arjan@infradead.org>
To: Amit Choudhary <amit2030@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061112221437.3572c275.amit2030@gmail.com>
References: <20061112221437.3572c275.amit2030@gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 13 Nov 2006 09:04:13 +0100
Message-Id: <1163405053.15249.104.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-12 at 22:14 -0800, Amit Choudhary wrote:
> Description: A mini HOWTO on implementing a new system call. 

> Although, I think that implementing new system calls is discouraged, many people do end up in implementing proprietary system calls. 



what do you mean by that? Do you mean open source-but-forked ? Yes that
is bad, because applications written to use that system call will not
work later on when the upstream kernel uses your system call number for
something else....



