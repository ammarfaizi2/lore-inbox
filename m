Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbULZXO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbULZXO4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 18:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbULZXO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 18:14:56 -0500
Received: from ds01.webmacher.de ([213.239.192.226]:21907 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S261269AbULZXN5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 18:13:57 -0500
In-Reply-To: <871xdc7jfk.fsf@deneb.enyo.de>
References: <200412250121_MC3-1-91AF-7FBB@compuserve.com> <20041226011222.GA1896@work.bitmover.com> <20041226030957.GA8512@work.bitmover.com> <yw1x7jn5bbj1.fsf@inprovide.com> <20041226160205.GB26574@work.bitmover.com> <yw1xmzw19bnn.fsf@inprovide.com> <20041226181837.GA28786@work.bitmover.com> <1104093456.16487.0.camel@localhost.localdomain> <3ECEAB02-578B-11D9-BCB8-000A95E3BCE4@dalecki.de> <871xdc7jfk.fsf@deneb.enyo.de>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D071CC7A-5793-11D9-9777-000A95E3BCE4@dalecki.de>
Content-Transfer-Encoding: 7bit
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       M?ns Rullg?rd <mru@inprovide.com>, Larry McVoy <lm@bitmover.com>
From: Martin Dalecki <martin@dalecki.de>
Subject: Re: lease.openlogging.org is unreachable
Date: Mon, 27 Dec 2004 00:13:55 +0100
To: Florian Weimer <fw@deneb.enyo.de>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004-12-27, at 00:01, Florian Weimer wrote:

> * Martin Dalecki:
>
>> Simply storing the first hostname used in a dot file for subsequent
>> reuse on client side, would be even easier I guess.
>
> You mean localhost.localdomain? 8-)

No the first value that worked in the whole setup of course. And I said 
it clearly that would
be just a workaround because uniqueness can be established in the 
easiest way on the side of
the part which is interested in the persistency - the server peer not 
the client.
"Simple" http servers do it by sending cookies around. Other call it 
"tokens".

