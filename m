Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965515AbWKKLBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965515AbWKKLBQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 06:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965973AbWKKLBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 06:01:16 -0500
Received: from dvhart.com ([64.146.134.43]:44749 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S965515AbWKKLBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 06:01:15 -0500
Message-ID: <4555AD39.8020803@mbligh.org>
Date: Sat, 11 Nov 2006 03:00:09 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: tglx@linutronix.de
Cc: Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
References: <9a8748490611081409x6b4cc4b4lc52b91c7b7b237a6@mail.gmail.com>	 <1163024531.3138.406.camel@laptopd505.fenrus.org>	 <20061108145150.80ceebf4.akpm@osdl.org>	 <1163064401.3138.472.camel@laptopd505.fenrus.org>	 <20061109013645.7bef848d.akpm@osdl.org>	 <1163065920.3138.486.camel@laptopd505.fenrus.org>	 <20061109111212.eee33367.akpm@osdl.org>	 <1163100115.3138.524.camel@laptopd505.fenrus.org>	 <20061109211121.GW4729@stusta.de>	 <1163107915.3138.541.camel@laptopd505.fenrus.org> <1163116618.8335.173.camel@localhost.localdomain>
In-Reply-To: <1163116618.8335.173.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That's no excuse, as Adrian pointed it out on LKML since weeks.
> 
> Also the kernel.org bugzilla has a real flaw:
> 
> There is no way to get informed of new entries automatically and
> filtered by Category and Component. At least I did not find a way and
> bugme-admin@osdl.org seems to be a black hole.

There is one list, bugme-new, that gets a copy of all bugs. The category
and component are broken out in headers simply so that you can filter it
yourself in whatever way you like.

Other than that, we can make each category owned by a "virtual user",
(many are already), and then multiple people can do an email watch on
that user.

bugme-admin alias should not be a black hole ... I get a copy of all
emails, as do a few other people. I don't recall seeing email from you
recently, but possibly a problem with spam filtering or something. If
you're having trouble, please send email directly to me if stuck.

M.
