Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266417AbSKOQmC>; Fri, 15 Nov 2002 11:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266408AbSKOQmC>; Fri, 15 Nov 2002 11:42:02 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:18853 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266417AbSKOQl7>; Fri, 15 Nov 2002 11:41:59 -0500
Date: Fri, 15 Nov 2002 11:48:47 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200211151648.gAFGmlt20997@devserv.devel.redhat.com>
To: Petr Baudis <pasky@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
In-Reply-To: <mailman.1037373001.29912.linux-kernel2news@redhat.com>
References: <225710000.1037241209@flay> <1037310164.10627.121.camel@plars> <1037311755.3180.214.camel@phantasy> <mailman.1037373001.29912.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The bugzilla database is a great idea but it should remain a database
>> i.e. a list.  Discussion and the initial reporting of bugs should remain
>> on the relevant lists _please_.
> 
> What about using the bugzilla email gateway? While it would be feasible that
> bugs should be added through the web interface, why not to automagically
> forward changes (new comments, attachments, maybe also status?) to appropriate
> mailing lists and absorb the replies to the thread back to bugzilla as the new
> comments?

Requestors and anyone with an account can add a list to 'cc' field,
so updates will get to the list. As for gatewaying from lists to
Bugzilla, I _strongly_ oppose it, and I hope DaveM would support me.
It's a door for spam and nothing else. If you have no IP connectivity
and read your linux-kernel with FIDO gateway and GoldED, use normal
ways of cooperating with maintainers. Bugzilla is complimentary,
not mandatory.

-- Pete
