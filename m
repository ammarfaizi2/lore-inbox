Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVAXSld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVAXSld (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 13:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVAXSld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 13:41:33 -0500
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:3342 "EHLO
	smtp-vbr11.xs4all.nl") by vger.kernel.org with ESMTP
	id S261563AbVAXSl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 13:41:27 -0500
Date: Mon, 24 Jan 2005 19:41:11 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Message-ID: <20050124184111.GA9335@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050124175449.GK3515@stusta.de> <20050124214336.2c555b53@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124214336.2c555b53@zanzibar.2ka.mipt.ru>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Mon, Jan 24, 2005 at 09:43:36PM +0300
> On Mon, 24 Jan 2005 18:54:49 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > It seems noone who reviewed the SuperIO patches noticed that there are 
> > now two modules "scx200" in the kernel...
> 
> They are almost mutually exlusive(SuperIO contains more advanced), 
> so I do not see any problem here.
> Only one of them can be loaded in a time.
> 
> So what does exactly bother you?
> 
lsmod in bugreports giving unspecific results, for example.

Kind regards,
Jurriaan
-- 
"So you believe."
Jewel ATerafin shrugged. "I have more than belief, but I don't have a
pressing need to convince you of anything."
	Michelle West - Sea of Sorrows.
Debian (Unstable) GNU/Linux 2.6.10-mm1 2x6078 bogomips load 0.52
