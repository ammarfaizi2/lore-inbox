Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWECVwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWECVwz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 17:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWECVwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 17:52:55 -0400
Received: from canuck.infradead.org ([205.233.218.70]:3006 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751367AbWECVwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 17:52:55 -0400
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
From: David Woodhouse <dwmw2@infradead.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: torvalds@osdl.org, js@linuxtv.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <20060503124100.9b50aa12.rdunlap@xenotime.net>
References: <20060430174426.a21b4614.rdunlap@xenotime.net>
	 <1146503166.2885.137.camel@hades.cambridge.redhat.com>
	 <20060502003755.GA26327@linuxtv.org>
	 <1146576495.14059.45.camel@pmac.infradead.org>
	 <20060502142050.GC27798@linuxtv.org>
	 <1146580308.17934.19.camel@pmac.infradead.org>
	 <20060502101113.17c75a05.rdunlap@xenotime.net>
	 <Pine.LNX.4.64.0605021137500.4086@g5.osdl.org>
	 <1146595853.19101.38.camel@pmac.infradead.org>
	 <Pine.LNX.4.64.0605021204240.4086@g5.osdl.org>
	 <1146612136.19101.47.camel@pmac.infradead.org>
	 <20060503124100.9b50aa12.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Wed, 03 May 2006 22:52:44 +0100
Message-Id: <1146693164.20773.62.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-03 at 12:41 -0700, Randy.Dunlap wrote:
> All references to "standard types" now say "standard C99 types".
> However, Linus still objects to the C99 integer typedefs AFAICT.
> Are we at an impasse?
> It would be a really Good Idea to have something about typedefs
> in Doc/CodingStyle. 

Absolutely, and you need to document the exceptions. That includes
saying that 'u32' et al are OK.

-- 
dwmw2

