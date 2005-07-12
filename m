Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVGLMEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVGLMEU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 08:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVGLMC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 08:02:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25803 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261371AbVGLMAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 08:00:55 -0400
Subject: Re: 2.6.13-rc2-mm2
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050712110505.GF28243@stusta.de>
References: <20050712021724.13b2297a.akpm@osdl.org>
	 <20050712110505.GF28243@stusta.de>
Content-Type: text/plain
Date: Tue, 12 Jul 2005 13:01:48 +0100
Message-Id: <1121169709.27264.146.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 13:05 +0200, Adrian Bunk wrote:
> Although it's not mentioned in the changelog, it seems the MTD GIT
> tree was dropped.
> 
> I noticed this because a compile error that was fixed in -mm1 is back.

What error? The MTD GIT tree is presumably absent from -mm because it
was pulled into Linus' tree last night.

-- 
dwmw2

