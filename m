Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267665AbSLSXv3>; Thu, 19 Dec 2002 18:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267669AbSLSXv3>; Thu, 19 Dec 2002 18:51:29 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:12225 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267665AbSLSXv2>; Thu, 19 Dec 2002 18:51:28 -0500
Date: Thu, 19 Dec 2002 18:59:30 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200212192359.gBJNxUI09113@devserv.devel.redhat.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dedicated kernel bug database
In-Reply-To: <mailman.1040338801.24520.linux-kernel2news@redhat.com>
References: <200212192155.gBJLtV6k003254@darkstar.example.net> <3E0240CA.4000502@inet.com> <mailman.1040338801.24520.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why are bugs automatically assigned to owners? 
> 	If there was an unassigned category that would make it 
> 	easy to query.

Query for "NEW" status for a component and do not put anything
into "owner" fireld.

> How else are those of us who want to help stabilize the 2.5 kernel supposed 
> 	to know which bugs are being worked on and which are not? 
> 	(Please dont tell me "email". Am I really supposed to email every 
> 	person who has a bug asking if they are really working on it or not?)

Of course.

> Could you make a list of all the people who have volunteered to be
> 	bugtracker maintainers and their respective kernel pieces. 

This is a reasonable request, IMHO.

> Also a list of people who arent maintainers but are available to help 
> 	could be useful for the owners to assign bugs to.

That's putting a cart in front of a horse. Such people have
to execute a simple Bugzilla to get lists, then select bugs
which they like. This way the overhead of maintaining such
lists disappears instantly.

-- Pete
