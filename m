Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263056AbUJ1NQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbUJ1NQj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 09:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263054AbUJ1NQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 09:16:38 -0400
Received: from canuck.infradead.org ([205.233.218.70]:36882 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S263056AbUJ1NPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 09:15:25 -0400
Subject: Re: My thoughts on the "new development model"
From: Arjan van de Ven <arjan@infradead.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       "michael@optusnet.com.au" <michael@optusnet.com.au>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>,
       "'Bill Davidsen'" <davidsen@tmr.com>, Massimo Cetra <mcetra@navynet.it>,
       Ed Tomlinson <edt@aei.ca>,
       "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       John Richard Moser <nigelenki@comcast.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <200410280907_MC3-1-8D5A-FF57@compuserve.com>
References: <200410280907_MC3-1-8D5A-FF57@compuserve.com>
Content-Type: text/plain
Message-Id: <1098969305.2642.19.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Thu, 28 Oct 2004 15:15:06 +0200
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-28 at 09:04 -0400, Chuck Ebbert wrote:
> > I'd expect vastly less than 1%, starting from the arch count, and then
> > making some conservative guesses about drivers. Drivers probably
> > actually take it down to far, far less than 1%.
> 
> 
>   Sure, but pretty much each installation uses a different 1%.

this is where the 80/20 rule holds:
80% of the people use the same 20 drivers ;)

so it's not as extreme as your words suggest (ok I cut a bunch out); but linux has so many users that even the few percent of users that has a less common setup leads to bugreport. And unlike some other OS'es, we all get to see all those reports...

