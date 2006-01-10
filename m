Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932698AbWAJVOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbWAJVOc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 16:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbWAJVOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 16:14:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:20404 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932698AbWAJVOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 16:14:31 -0500
Subject: Re: X86_64 and X86_32 bit performance difference [Revisited]
From: Arjan van de Ven <arjan@infradead.org>
To: Nauman Tahir <nauman.tahir@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.kernel.org
In-Reply-To: <f0309ff0601100249y4ffa3596sa2a623015cdca66b@mail.gmail.com>
References: <f0309ff0601082229u3fc5e415m12be9dc921f4a099@mail.gmail.com>
	 <1136793080.2936.14.camel@laptopd505.fenrus.org>
	 <f0309ff0601100249y4ffa3596sa2a623015cdca66b@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 22:14:25 +0100
Message-Id: <1136927665.2846.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 02:49 -0800, Nauman Tahir wrote:
> On 1/9/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > On Sun, 2006-01-08 at 22:29 -0800, Nauman Tahir wrote:
> > > Hello All
> > > I have posted this problem before. Now mailing again after testing as
> > > recommeded in previous replys.
> > > My configuration is:
> > >
> > > Hardware:
> > > HP Proliant DL145 (2 x AMD Optaron 144)
> > > 14 GB RAM
> > >
> > > OS:
> > > FC 4
> > >
> > > Kernel
> > > 2.6.xx
> >
> > You *STILL* have not posted the URL to your source code.
> > How is anyone supposed to help you without that?????
> 
> I have attached a file which I use as thread API. Complete code is
> quiet large and also need proper description. which i would be posting
> if needed.

well you don't give any of the block layer code, I'd say more code is
needed. Just put all of it online somewhere and post the URL...



