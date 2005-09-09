Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbVIIHcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbVIIHcd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 03:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbVIIHcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 03:32:33 -0400
Received: from ip18.tpack.net ([213.173.228.18]:21639 "HELO mail.tpack.net")
	by vger.kernel.org with SMTP id S932495AbVIIHcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 03:32:32 -0400
Message-ID: <43213B18.3020606@tpack.net>
Date: Fri, 09 Sep 2005 09:34:48 +0200
From: Tommy Christensen <tommy.christensen@tpack.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Netdev List <netdev@vger.kernel.org>,
       nhorman@tuxdriver.com
Subject: Re: [PATCH] 3c59x: read current link status from phy
References: <200509080125.j881PcL9015847@hera.kernel.org> <431F9899.4060602@pobox.com> <Pine.LNX.4.63.0509081351160.21354@dingo.iwr.uni-heidelberg.de> <1126184700.4805.32.camel@tsc-6.cph.tpack.net> <Pine.LNX.4.63.0509081521140.21354@dingo.iwr.uni-heidelberg.de> <1126190554.4805.68.camel@tsc-6.cph.tpack.net> <Pine.LNX.4.63.0509081713500.22954@dingo.iwr.uni-heidelberg.de> <4320BD96.3060307@tpack.net> <20050909010816.GA28653@tuxdriver.com>
In-Reply-To: <20050909010816.GA28653@tuxdriver.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:
> Any chance you could re-diff this to apply on top of the patch posted
> earlier today by Neil Horman?

Sure, but his patch didn't apply to -git8.

If Neil would please resend, then I can diff against that.


-Tommy
