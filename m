Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267620AbUHTI10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267620AbUHTI10 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbUHTI10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:27:26 -0400
Received: from gprs214-9.eurotel.cz ([160.218.214.9]:2947 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267620AbUHTI0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:26:34 -0400
Date: Fri, 20 Aug 2004 10:26:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@zip.com.au>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, david-b@pacbell.net
Subject: Re: Use global system_state to avoid system-state confusion
Message-ID: <20040820082616.GJ25317@elf.ucw.cz>
References: <20040819113600.GA1317@elf.ucw.cz> <1092915767.19218.50.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092915767.19218.50.camel@laptop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +		if (system_state == SYSTEM_SWSUSP_SNAPSHOT)
> 
> Would you consider getting rid of the 'SWSUSP'? It's so ugly!
> SYSTEM_SNAPSHOT would be clear and concise.

Ok.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
