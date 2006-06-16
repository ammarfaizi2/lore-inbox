Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWFPP4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWFPP4N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 11:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWFPP4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 11:56:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24300 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751468AbWFPP4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 11:56:12 -0400
Subject: Re: sock_alloc() symbol removed in 2.6.10
From: Arjan van de Ven <arjan@infradead.org>
To: Ralf Dauberschmidt <rfk@digitalstyle.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000f01c69133$41114bd0$0200000a@redstorm>
References: <000f01c69133$41114bd0$0200000a@redstorm>
Content-Type: text/plain
Date: Fri, 16 Jun 2006 17:56:10 +0200
Message-Id: <1150473371.3070.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-16 at 12:54 +0200, Ralf Dauberschmidt wrote:
> Hello,
> 
> As of kernel 2.6.10 the symbol export of the sock_alloc() function has been
> removed (I assume in the course of "Remove dead socket layer exports"). Can
> anybody tell me why this happened? Why is it "dead"?

nobody used it ?


what driver are you looking at that wants to use it?


