Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbUD3Wsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUD3Wsk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 18:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbUD3Wsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 18:48:40 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:32151 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261779AbUD3Wsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 18:48:37 -0400
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
From: David Woodhouse <dwmw2@infradead.org>
To: Keith D Burgess Jr <kburgessjr@mailblocks.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <kburgessjr-05pZrAV1BpTwXRPAFHKqDX8TUUVHXXq@mailblocks.com>
References: <kburgessjr-05pZrAV1BpTwXRPAFHKqDX8TUUVHXXq@mailblocks.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1083365314.32758.62.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1.dwmw2.1) 
Date: Fri, 30 Apr 2004 23:48:34 +0100
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-28 at 11:56 -0700, Keith D Burgess Jr wrote:
> In summary, I firmly feel that there needs to be a mindset change if 
> Linux is to eat away at Windows market share on the desktops. Let's 
> take a certain Linux distributor as an example; here is a quote from a 
> recent posting on the 4K stacks issue:

Quite frankly I don't give a two hoots about market share. If I wanted
my code to be used by third parties _without_ them having to free their
own code, then I'd have contributed to a BSD-licensed kernel instead of
a GPL'd kernel; or I'd have dual-licensed it.

If you think the BSD approach is so much more conducive to market share,
and if you think market share is more important than freedom, then go
elsewhere. Maybe you can use Windows -- that has BSD code in it, doesn't
it? Or MacOS X perhaps? I don't really care much -- just go away.

> "Too bad. External binary modules never have, and never will hold back 
> development. NVIDIA need to issue driver updates that work accordingly."
> 
> Reworded from a user-focused perspective:

Reworded from a copyright-holder's perspective:

"Use a copy of my work outside the terms of its licence, and other than
provided for by 'Fair Use' doctrine¹, and you are committing a criminal
offence."

-- 
dwmw2

¹ cf. http://www.hmso.gov.uk/acts/acts1988/Ukpga_19880048_en_4.htm

