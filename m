Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262458AbVAJUL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbVAJUL0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbVAJTrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 14:47:15 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:9165 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262485AbVAJTc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 14:32:59 -0500
Subject: Re: Linux 2.6.10-ac8 oops in cache_alloc_refill
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sami Farin <7atbggg02@sneakemail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050110004307.GA10288@m.safari.iki.fi>
References: <20050110004307.GA10288@m.safari.iki.fi>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105381363.12004.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 10 Jan 2005 18:28:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-10 at 00:43, Sami Farin wrote:
> 2.6.9 (patched to death) worked nicely for the last 15 days,
> then I thought I could try if VM+USB had improved in 2.6.10.
> I did basically "make oldconfig" and added a couple of patches...

Is it repeatable without all the random patches applied ?

