Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423274AbWJSLLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423274AbWJSLLQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 07:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423273AbWJSLLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 07:11:16 -0400
Received: from poczta.o2.pl ([193.17.41.142]:15490 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1423277AbWJSLLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 07:11:15 -0400
Date: Thu, 19 Oct 2006 13:16:20 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] DocBook with .txt or .html versions?
Message-ID: <20061019111620.GD3296@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	linux-kernel@vger.kernel.org
References: <20061018114240.GA3202@ff.dom.local> <200610192214.23618.elinar@ihug.co.nz> <20061019100932.GC3296@ff.dom.local> <200610192329.07361.elinar@ihug.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610192329.07361.elinar@ihug.co.nz>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 11:29:07PM +1300, Glenn Enright wrote:
> On Thursday 19 October 2006 23:09, Jarek Poplawski wrote:
> > I'm sorry if I implied... It is not a problem of limited resources.
> > If I can choose I allways tend to install only necessary software.
> I suppose that certainly helps when chasing bugs.

There are also security reasons.

> Did you have an 
> alternative way of building the docs in mind that could be lighter? I 
> admit the tree you described does seem a large pull just so you can 
> read some text for one source package... even if it is the kernel.

Yes. My preferred alternative way is used by 
all the rest of Documentation already.

My other preferred alternative way, used by
many programs like apache, postgresql, mysql,
samba etc. is html, which could be read even 
on consoles with lynx or links. 

If there is a problem of space let it be
accessible in ftp subdirectory at least.

Cheers,
Jarek P.
