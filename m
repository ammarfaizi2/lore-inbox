Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbTLWQTd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 11:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbTLWQTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 11:19:33 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:29122 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261299AbTLWQTJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 11:19:09 -0500
Date: Wed, 24 Dec 2003 00:19:00 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re:  DevFS vs. udev
In-Reply-To: <E1AYl4w-0007A5-R3@O.Q.NET>
Message-ID: <Pine.LNX.4.44.0312240005180.4342-100000@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Dec 2003, Bradley W. Allen wrote:

> DevFS was written by an articulate person who solved a lot of
> problems.  udev sounds more like a thug who's smug about winning,
> not explaining himself, saying things like "oh, the other guy
> disappeared, so who cares, you have to use my code, too bad it sucks".
> 

Well, this issue has certainly attracted a lot of debate.

I have barely used devfs, but I like much of the implementation. I'm not 
familiar with udev either and so won't comment on it.

When this thread first started I had a look at the code and, I must admit, 
it is a little untidy (ugly actually). I think it would require a 
considerable amount of effort just to make it maintainable. Maybe then 
some of the problems (whatever they are) would present themselves.

So it's deprecated in 2.6. Is this only because no one is willing to take 
on maintenance of it or is it to late?

Ian


