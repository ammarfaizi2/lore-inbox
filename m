Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWEAQ6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWEAQ6t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 12:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWEAQ6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 12:58:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5335 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932152AbWEAQ6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 12:58:48 -0400
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
From: David Woodhouse <dwmw2@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0605011559010.31804@yvahk01.tjqt.qr>
References: <20060430174426.a21b4614.rdunlap@xenotime.net>
	 <Pine.LNX.4.61.0605011559010.31804@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Mon, 01 May 2006 17:58:50 +0100
Message-Id: <1146502730.2885.128.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-01 at 16:00 +0200, Jan Engelhardt wrote:
> What about task_t vs struct task_struct? Both are used in the kernel. 

task_t should probably die.

-- 
dwmw2

