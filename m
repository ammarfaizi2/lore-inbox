Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262773AbUKRPzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262773AbUKRPzX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 10:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbUKRPxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 10:53:32 -0500
Received: from canuck.infradead.org ([205.233.218.70]:34064 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262756AbUKRPwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 10:52:03 -0500
Subject: Re: [patch] 2.6.10-rc2-mm2: MTD_XIP dependencies
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>, nico@cam.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
In-Reply-To: <20041118154110.GE4943@stusta.de>
References: <20041118021538.5764d58c.akpm@osdl.org>
	 <20041118154110.GE4943@stusta.de>
Content-Type: text/plain
Message-Id: <1100793112.8191.7315.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Thu, 18 Nov 2004 15:51:52 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-18 at 16:41 +0100, Adrian Bunk wrote:
> Let's put the dependencies from the #error into the Kconfig file:

Looks sane to me. Nico?

-- 
dwmw2

