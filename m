Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbVHQFtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbVHQFtF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 01:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbVHQFtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 01:49:05 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:30411 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750898AbVHQFtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 01:49:04 -0400
Subject: Re: compiling only one module in kernel version 2.6?
From: Steven Rostedt <rostedt@goodmis.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: sudoyang@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050816224101.295806c8.rdunlap@xenotime.net>
References: <4f52331f050816190957cec081@mail.gmail.com>
	 <1124248729.5764.70.camel@localhost.localdomain>
	 <20050816224101.295806c8.rdunlap@xenotime.net>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 17 Aug 2005 01:48:59 -0400
Message-Id: <1124257739.5764.107.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-16 at 22:41 -0700, Randy.Dunlap wrote:
> 
> Sam only added make .ko build support very recently,
> so it could easily depend on what kernel verison Fong is using.

That could very well explain it. I'm doing this on 2.6.13-rc6-rt6
(2.6.13-rc6 with Ingo's rt6 patch applied).  So I really do have a
recent kernel.

-- Steve


