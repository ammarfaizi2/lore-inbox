Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263938AbTFGXQh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 19:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbTFGXQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 19:16:37 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:48831 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S263938AbTFGXQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 19:16:36 -0400
Subject: Re: [FUN] Re: [PATCH] Move BUG/BUG_ON/WARN_ON to asm headers
From: Christophe Saout <christophe@saout.de>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030607145633.V626@nightmaster.csn.tu-chemnitz.de>
References: <16097.56616.35782.882995@argo.ozlabs.ibm.com>
	 <20030607145633.V626@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain
Message-Id: <1055028601.7146.0.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 08 Jun 2003 01:30:02 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo!

> On Sat, Jun 07, 2003 at 10:40:08PM +1000, Paul Mackerras wrote:
> > +struct bug_entry *module_find_bug(unsigned long bugaddr)
> 
> A wet dream of many driver writers has come true: A function,
> which finds the bug in their module ;-)

*The* bug? That sounds very optimistic. ;-)

-- 
Christophe Saout <christophe@saout.de>

