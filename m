Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030488AbWHXVz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030488AbWHXVz1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030490AbWHXVz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:55:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2284 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030488AbWHXVz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:55:26 -0400
Subject: Re: [PATCH 0/4] Compile kernel with -fwhole-program --combine
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, linux-tiny@selenic.com, devel@laptop.org
In-Reply-To: <20060824214919.GT19810@stusta.de>
References: <1156429585.3012.58.camel@pmac.infradead.org>
	 <1156433068.3012.115.camel@pmac.infradead.org>
	 <20060824214919.GT19810@stusta.de>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 22:54:52 +0100
Message-Id: <1156456492.2984.2.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 23:49 +0200, Adrian Bunk wrote:
> 
> make[1]: *** No rule to make target
> `/home/bunk/linux/linux-2.6.18-rc4/dummy.c', needed by `init/init.o'.
> Stop. 

oops, sorry. touch dummy.c -- evil makefile hack ;)

-- 
dwmw2

