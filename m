Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVC0UBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVC0UBv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 15:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVC0UBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 15:01:51 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:43012 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261506AbVC0UBo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 15:01:44 -0500
Date: Sun, 27 Mar 2005 22:01:42 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH] typo fix in Documentation/eisa.txt
Message-Id: <20050327220142.60ee32fc.khali@linux-fr.org>
In-Reply-To: <200503272145.10266.eike-kernel@sf-tec.de>
References: <200503271554.44382.eike-kernel@sf-tec.de>
	<20050327213124.1e82828b.khali@linux-fr.org>
	<200503272145.10266.eike-kernel@sf-tec.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >  Force the probing code to probe EISA slots even when it cannot find an
> > > -EISA compliant mainboard (nothing appears on slot 0). Defaultd to 0
> > > +EISA compliant mainboard (nothing appears on slot 0). Default to 0
> > >  (don't force), and set to 1 (force probing) when either
> > >  CONFIG_ALPHA_JENSEN or CONFIG_EISA_VLB_PRIMING are set.
> >
> > Wouldn't it rather be "Defaults"?
> 
> Damn, yes. Every time I read it again I feel a little bit more
> comfortable with s/are set/is set/. Am I right or is it already too
> late for useful work?

"is" is better, even if both are commonly used in this case. And no,
it's not to late.

-- 
Jean Delvare
