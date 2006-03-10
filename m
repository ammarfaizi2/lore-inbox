Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbWCJHjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWCJHjq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 02:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWCJHjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 02:39:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:1763 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751471AbWCJHjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 02:39:46 -0500
Subject: Re: [2.6.16-rc5-m3 PATCH] inotify: add the monitor for the event
	source
From: Arjan van de Ven <arjan@infradead.org>
To: Yi Yang <yang.y.yi@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <4410D607.5080102@gmail.com>
References: <440F075F.1030404@gmail.com>
	 <1141836798.12175.1.camel@laptopd505.fenrus.org>
	 <440FBA9C.3050109@gmail.com>
	 <1141882513.2883.2.camel@laptopd505.fenrus.org>
	 <440FFB7F.8050902@gmail.com>
	 <1141932941.2883.26.camel@laptopd505.fenrus.org>
	 <4410D607.5080102@gmail.com>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 08:39:40 +0100
Message-Id: <1141976381.2876.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >>>       
> >> For this case you said, this patch has now way really, do you have a 
> >> good way to handle this case?
> >>     
> >
> > it sounds that what you want to achieve is broken in the first place...
> > (or should use audit etc)
> >   
> As I known, BSD process audit only

I'm not talking about BSD audit but about the CAPP security audit
framework.


