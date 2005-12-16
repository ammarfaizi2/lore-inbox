Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbVLPIC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbVLPIC6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 03:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbVLPIC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 03:02:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24963 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932173AbVLPIC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 03:02:57 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Arjan van de Ven <arjan@infradead.org>
To: Alex Davis <alex14641@yahoo.com>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20051216061605.46520.qmail@web50211.mail.yahoo.com>
References: <20051216061605.46520.qmail@web50211.mail.yahoo.com>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 09:02:48 +0100
Message-Id: <1134720168.2992.8.camel@laptopd505.fenrus.org>
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


> I understand that, and am grateful for the effort, but the point is it's not ready. Are you
> expecting people to lose an important feature of their
> laptop until you get the driver ready? 
> 
> 
> I code, therefore I am

if you code.. why don't you go help coding with the people writing the
broadcom drivers? How is this ONLY our problem? Linux is a cooperative
thing: you take but you also give back. If you're a coder, this is the
perfect opportunity to give something back and help the bcm43xx guys
with debugging and coding and testing....


