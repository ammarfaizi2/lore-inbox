Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291620AbSCWViz>; Sat, 23 Mar 2002 16:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293175AbSCWVip>; Sat, 23 Mar 2002 16:38:45 -0500
Received: from redjack.ninds.nih.gov ([165.112.20.21]:36225 "EHLO
	redjack.ninds.nih.gov") by vger.kernel.org with ESMTP
	id <S291620AbSCWVig>; Sat, 23 Mar 2002 16:38:36 -0500
Date: Sat, 23 Mar 2002 16:38:34 -0500 (EST)
From: Luke Schierer <lschiere@gmu.edu>
To: linux-kernel@vger.kernel.org
Subject: problems getting sigchld
Message-ID: <Pine.LNX.4.21.0203231634100.30459-100000@redjack.ninds.nih.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working with the gaim development team, and we've run across something
really odd.  When I run gaim as root, it is able to catch SIGCHLD, but
when I run as a normal user, it is not. I've tried the 2.2.20 kernel I've
compiled myself, and also a stock 2.2.20 kernel downloaded with apt-get,
both on an intell pII running debian woody.

another user is expiriencing the same thing with a stock 2.4.19-pre4 on a
2xPIII 850

any ideas what could be causing this?
thanks,
Luke

ps, please cc me in any replies, because I am not on the list. 


-This email is made of 100% recycled electrons.

