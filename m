Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262681AbVA0SSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbVA0SSs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 13:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262684AbVA0SSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 13:18:48 -0500
Received: from gprs213-93.eurotel.cz ([160.218.213.93]:8576 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262681AbVA0SSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 13:18:44 -0500
Date: Thu, 27 Jan 2005 19:16:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: Patch 1/6  introduce sysctl
Message-ID: <20050127181525.GA4784@elf.ucw.cz>
References: <20050127101117.GA9760@infradead.org> <20050127101201.GB9760@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127101201.GB9760@infradead.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This first patch of the series introduces a sysctl (default off) that
> enables/disables the randomisation feature globally. Since randomisation may
> make it harder to debug really tricky situations (reproducability goes
> down), the sysadmin needs a way to disable it globally.

Well, for distribution vendors, seeing "these reports from users are
same error" will becoe harder, too, and sysctl can not help there :-(.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
