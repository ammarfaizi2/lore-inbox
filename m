Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422744AbWATFEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422744AbWATFEW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 00:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422747AbWATFEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 00:04:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52360 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422744AbWATFEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 00:04:21 -0500
Subject: Re: [PATCH]: Fix regression added by ppoll/pselect code.
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: davem@davemloft.net, torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060119205648.221fd3f0.akpm@osdl.org>
References: <20060119.164042.74751188.davem@davemloft.net>
	 <1137732487.30084.194.camel@localhost.localdomain>
	 <20060119205648.221fd3f0.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 18:04:24 +1300
Message-Id: <1137733464.30084.198.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 20:56 -0800, Andrew Morton wrote:
> a) They tell you what the magic numbers _mean_.

Yeah, but so does the context.

> b) Ever tried counting nine contiguous zeros at 4AM, making sure that
>    they're all there?

I work on the principle that if I can't even count any more, it's time I
stopped looking at code altogether :)

Do it if you really want to, by all means -- I just think it's a little
gratuitous. Doesn't really hurt though.

-- 
dwmw2

