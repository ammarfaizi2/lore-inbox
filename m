Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267384AbUGNNmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267384AbUGNNmt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 09:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267385AbUGNNmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 09:42:49 -0400
Received: from gprs214-226.eurotel.cz ([160.218.214.226]:52864 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267384AbUGNNml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 09:42:41 -0400
Date: Wed, 14 Jul 2004 15:42:27 +0200
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: netdev@oss.sgi.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ipw2100 wireless driver
Message-ID: <20040714134227.GA8978@elf.ucw.cz>
References: <20040714114135.GA25175@elf.ucw.cz> <20040714131523.GA498@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714131523.GA498@ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > What is the status of ipw2100? Is there chance that it would be pushed
> > into mainline?
> > 
> > I have few problems with that:
> > 
> > * it will not compile with gcc-2.95. Attached patch fixes one problem
> > but more remain.
> 
> Wouldn't "struct sk_buff **fragments" be a more correct fix?

Yep, that would certainly be better. I'll wait if I get some  reply
from ipw2100 people. If so I'll update the patch.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
