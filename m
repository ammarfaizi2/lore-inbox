Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWD3Hg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWD3Hg4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 03:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWD3Hg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 03:36:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47589 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751038AbWD3Hg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 03:36:56 -0400
Subject: Re: better leve triggered IRQ management needed
From: Arjan van de Ven <arjan@infradead.org>
To: Neil Brown <neilb@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Stephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <17492.16811.469245.331326@cse.unsw.edu.au>
References: <20060424114105.113eecac@localhost.localdomain>
	 <1146345911.3302.36.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0604291453220.3701@g5.osdl.org>
	 <17492.16811.469245.331326@cse.unsw.edu.au>
Content-Type: text/plain
Date: Sun, 30 Apr 2006 09:36:49 +0200
Message-Id: <1146382609.20760.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> .
> 
> 5/ Something I haven't thought of.


do a background poll and if that gets a lot of "hits" maybe increase the
frequency of it

