Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbVHQFy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbVHQFy6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 01:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbVHQFy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 01:54:58 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:6275 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750867AbVHQFy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 01:54:57 -0400
Subject: Re: compiling only one module in kernel version 2.6?
From: Steven Rostedt <rostedt@goodmis.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, sudoyang@gmail.com
In-Reply-To: <1124257739.5764.107.camel@localhost.localdomain>
References: <4f52331f050816190957cec081@mail.gmail.com>
	 <1124248729.5764.70.camel@localhost.localdomain>
	 <20050816224101.295806c8.rdunlap@xenotime.net>
	 <1124257739.5764.107.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 17 Aug 2005 01:54:50 -0400
Message-Id: <1124258090.5764.109.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 01:48 -0400, Steven Rostedt wrote:
> On Tue, 2005-08-16 at 22:41 -0700, Randy.Dunlap wrote:
> > 
> > Sam only added make .ko build support very recently,
> > so it could easily depend on what kernel verison Fong is using.
> 
> That could very well explain it. I'm doing this on 2.6.13-rc6-rt6
> (2.6.13-rc6 with Ingo's rt6 patch applied).  So I really do have a
> recent kernel.
> 

I just did this on a 2.6.9 vanilla kernel, and it still worked. How
"recent" did Sam do this?

-- Steve


