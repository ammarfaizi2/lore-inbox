Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965225AbVI0XAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbVI0XAi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 19:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965226AbVI0XAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 19:00:38 -0400
Received: from rrcs-67-78-243-58.se.biz.rr.com ([67.78.243.58]:35471 "EHLO
	mail.concannon.net") by vger.kernel.org with ESMTP id S965225AbVI0XAh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 19:00:37 -0400
Message-ID: <4339CF44.1020108@concannon.net>
Date: Tue, 27 Sep 2005 19:01:24 -0400
From: Michael Concannon <mike@concannon.net>
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1.centos4 (X11/20050721)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Concannon <mike@concannon.net>
CC: Tomasz Torcz <zdzichu@irc.pl>, linux-kernel@vger.kernel.org
Subject: Re: spurious mouse clicks
References: <433164F4.40205@concannon.net> <20050921140857.GA17224@irc.pl> <43316B2A.4040303@concannon.net> <43316C36.1010703@concannon.net> <4331B9B0.6050300@concannon.net>
In-Reply-To: <4331B9B0.6050300@concannon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, it seems that others have run into this as well and that the issue 
might be the result of the introduction of a more specific 
driver/features (for Alps touchpad) which accompanied breakage, er "new 
features", of the more generic driver...

Some embarrassingly slight changes to my google search terms popped up 
this conversation from this summer (I am just waiting for google to 
release the tool that knows what I am looking for before I ask.  Either 
that or the end of civilization which would clearly come if they took 
the old deja-news archives off-line again...):

http://groups.google.com/group/fa.linux.kernel/browse_thread/thread/1af60302c31aa4bf/f0e91763bafea020?lnk=st&q=touchpad+sensitivity+2.6.12&rnum=1#f0e91763bafea020

So, I guess I will have to break down and:

a. read that thread
b. change drivers to the more specific Alps driver... 
c. perhaps tweak some parms to get it to stop interpreting random mouse 
movements as clear statements that I would like to delete files and 
trash my desktop...

/mike
