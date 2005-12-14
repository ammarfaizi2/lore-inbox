Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbVLNVQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbVLNVQK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 16:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbVLNVQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 16:16:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37605 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964969AbVLNVQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 16:16:08 -0500
Subject: Re: irq balancing question
From: Arjan van de Ven <arjan@infradead.org>
To: JaniD++ <djani22@dynamicweb.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <024501c600f2$24e8ccc0$0400a8c0@dcccs>
References: <024501c600f2$24e8ccc0$0400a8c0@dcccs>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 22:16:04 +0100
Message-Id: <1134594964.9442.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 22:05 +0100, JaniD++ wrote:
> Hello, list,
> 
> I try to tune my system with manually irq assigning, but this simple not
> works, and i don't know why. :(
> I have already read all the documentation in the kernel tree, and search in
> google, but i can not find any valuable reason.


which chipset? there is a chipset that is broken wrt irq balancing so
the kernel refuses to do it there...


