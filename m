Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbUBUCo0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 21:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbUBUCo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 21:44:26 -0500
Received: from ambr.mtholyoke.edu ([138.110.1.10]:37638 "EHLO
	ambr.mtholyoke.edu") by vger.kernel.org with ESMTP id S261486AbUBUCoR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 21:44:17 -0500
Date: Fri, 20 Feb 2004 21:44:14 -0500 (EST)
From: Ron Peterson <rpeterso@MtHolyoke.edu>
To: linux-kernel@vger.kernel.org
Subject: network / performance problems
Message-ID: <Pine.OSF.4.21.0402202128320.394202-100000@mhc.mtholyoke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have several new Dell 2650's in various stages of production.  They are
dual xeon machines, hyperthreaded, w/ built in broadcom Gbit
adapters.  I've also installed IntelPRO 1000/MT dual port
adapters.  I have tried various combinations of these adapters and kernels
2.4.24 and 2.6.3, but continue to have problems with slowly degrading
network performance.  Under heavy load, thing really go sour, and I've
actually had to reboot to get things back again.

I've assembled some data at the following location, which I hope provides
some additional insight into the nature of my difficulties.  These include
smokeping graphs, sundry stats, and some commentary.  I am of course happy
to provide any additional information that would be helpful.  It's almost
certain that I've neglected to mention the once crucial detail that makes
everything clear (likely just me being obtuse)... ;)

http://depot.mtholyoke.edu:8080/tmp/

I've not subscribed to the lkml (I know, boo), so would appreciate
CC's.  I will happily subscribe if anyone feels I'm being outrageously
gauche.

(Thanks in general for all the stuff you guys do.  Amazing!)

_________________________
Ron Peterson
Network & Systems Manager
Mount Holyoke College

