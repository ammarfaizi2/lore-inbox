Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268944AbUIHINY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268944AbUIHINY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 04:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268947AbUIHINY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 04:13:24 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:60894 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268944AbUIHINU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 04:13:20 -0400
Message-Id: <200409080812.i888CDo29381@owlet.beaverton.ibm.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: latency.c [was: Re: 2.6.9-rc1-mm1] 
In-reply-to: Your message of "Sun, 05 Sep 2004 01:10:07 +0200."
             <200409050110.07728.rjw@sisk.pl> 
Date: Wed, 08 Sep 2004 01:12:13 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I've fiddled a bit with both the latency.c programs.  I've added some
    options to them etc.  In particular, now you can specify a program
    to run and monitor instead of a pid, which is handy if you need to
    monitor processes that exit quickly.  Everything is documented in
    the sources (attached).  I thought you might find this useful. :-)

Thank you much! yes, that will make it more useful.  I'll add it to my
backlog and see if I can't get it out to the web page this week.

Rick
