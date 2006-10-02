Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965209AbWJBSH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965209AbWJBSH6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965211AbWJBSH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:07:58 -0400
Received: from dvhart.com ([64.146.134.43]:30851 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S965209AbWJBSH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:07:57 -0400
Message-ID: <4521557C.3060500@mbligh.org>
Date: Mon, 02 Oct 2006 11:07:56 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lee Revell <rlrevell@joe-job.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Spam, bogofilter, etc
References: <1159539793.7086.91.camel@mindpipe>  <20061002100302.GS16047@mea-ext.zmailer.org>  <1159802486.4067.140.camel@mindpipe> <45212F39.5000307@mbligh.org>  <Pine.LNX.4.64.0610020933020.3952@g5.osdl.org> <1159811392.8907.36.camel@localhost.localdomain> <Pine.LNX.4.64.0610021050350.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610021050350.3952@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>MX checking is as broken or more broken than bayes.
> 
> I have to say, OSDL has been doing MX checking, and it's effective as 
> hell. Most importantly, when it _does_ break, it's not because some 
> "content" is considered inappropriate, it's because some ISP does 
> something technically wrong.
> 
> OSDL also refused to talk to open mail relays etc. I got into something of 
> a (fairly civilized) shouting match with John Gilmore over it, who used to 
> send out email from a "fake open mail relay" on princuple (maybe he still 
> does). He claimed I was censoring his free speech rights when I didn't 
> read his emails, but I just told him that I was expressing my right to not 
> listen to people who are so stupid that they can't configure their email 
> servers.

That was actually pretty broken. Sending Andrew email stopped working
for ages. IIRC because I was sending email from my home address through
the IBM work server. It's not a trouble-free solution, and otherwise
fairly reasonable things stop working. I forget what the OSDL admins
did in the end ... I think put in a specific exception for an IP range.

M.
