Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbUJYLrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbUJYLrX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 07:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbUJYLrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 07:47:22 -0400
Received: from canuck.infradead.org ([205.233.218.70]:49165 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261699AbUJYLrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 07:47:15 -0400
Subject: Re: 2.6.9-mm1
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041022032039.730eb226.akpm@osdl.org>
References: <20041022032039.730eb226.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1098704827.2798.18.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 25 Oct 2004 13:47:09 +0200
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   - md updates: these are blocked by a minor bunfight over one of Neil's
>     procfs innovations.  He's reworking the patches so we can defer that
>     decision.

does that mean it'll use the new sysfs based (dbus) generic event
mechanism instead? that sounds like a good step forward indeed.
-- 

