Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVADHnC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVADHnC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 02:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbVADHnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 02:43:01 -0500
Received: from canuck.infradead.org ([205.233.218.70]:1811 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261553AbVADHmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 02:42:54 -0500
Subject: Re: starting with 2.7
From: Arjan van de Ven <arjan@infradead.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Adrian Bunk <bunk@stusta.de>, Rik van Riel <riel@redhat.com>,
       Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
In-Reply-To: <41D9D69C.1070002@tmr.com>
References: <20050103153438.GF2980@stusta.de>
	 <1697129508.20050102210332@dns.toxicfilms.tv>
	 <1104767943.4192.17.camel@laptopd505.fenrus.org> <41D9D69C.1070002@tmr.com>
Content-Type: text/plain
Date: Tue, 04 Jan 2005 08:42:36 +0100
Message-Id: <1104824557.4215.1.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > as long as more things get fixed than new bugs introduced (and that
> > still seems to be the case) things only improve in 2.6. 
> > 
> > The joint approach also has major advantages, even for quality:
> > All testing happens on the same codebase. 
> > Previously, the testing focus was split between the stable and unstable
> > branch, to the detriment of *both*.
> 
> You think so? I think the number of people testing the 2.4.xx-rc 
> versions AND the 2.6.xx-bkN versions is a small (nonzero) percentage of 
> total people trying any new release. I think people test what they plan 
> to use, so there's less competition for testers than you suggest. People 
> staying with 2.4 test that, people wanting or needing to move forward 
> test 2.6.
> 
Actually I suspect the number of people testing 2.4.xx-rc is *really*
small now. My point however was more towards a 2.6 / 2.7 split, where
the people who want to test newest do 2.7 while people who want to test
stable test 2.6; right now those two groups test basically the same
codebase.

