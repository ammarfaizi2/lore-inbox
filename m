Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWEVKu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWEVKu2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 06:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWEVKu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 06:50:28 -0400
Received: from mail.siegenia-aubi.com ([217.5.180.129]:5782 "EHLO
	alg-1.siegenia-aubi.com") by vger.kernel.org with ESMTP
	id S1750741AbWEVKu1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 06:50:27 -0400
Message-ID: <FC7F4950D2B3B845901C3CE3A1CA6766012A9E71@mxnd200-9.si-aubi.siegenia-aubi.com>
From: =?iso-8859-1?Q?=22D=F6hr=2C_Markus_ICC-H=22?= 
	<Markus.Doehr@siegenia-aubi.com>
To: "'Helge Hafting'" <helge.hafting@aitel.hist.no>
Cc: "'Peter Gordon'" <codergeek42@gmail.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: RE: replacing X Window System !
Date: Mon, 22 May 2006 12:50:20 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> >Did you actually do that? Starting Firefox over a 6 Mbit VPN takes 
> >about 3 minutes on a FAST machine. That´s not acceptable - our users 
> >want (almost) immediate response to an application, to clicking and 
> >waiting 10 seconds until the app is doing something.
> >  
> >
> It is not that bad.  I tried starting firefox on a machine 
> 20km away, using a 5Mbps ADSL link from the "wrong" end.  (I 
> ssh'ed into my home pc from work.) Firefox started in 55s, 
> not 3min. Still bad, but that is a firefox problem, not a 
> generic X-tunneling problem.  I can start the lyx word 
> processor in 3s over the same link, and have decent 
> performance while using it too.

55 seconds to start an application... That´s not acceptable. Why do you
think it´s a Firefox problem? Did you try this with a Java application? 

I don´t wanna blame X in general, just saying it is useless if you´re
sitting in Hungary or Poland and want to work remotely - in comparision to
M$´s  RDP. 

The question for me is not "X or not X" - but how to enable people to start
e. g. "sam" on an HP-UX box without needing to wait minutes before the
application starts. It works - for sure, but the speed is for our needs not
acceptable. Additionally ~ 60 ssh sessions on a single box will but a lot of
CPU load on the system beside the fact, that you need a BIG BIG pipe.


-- 
Markus
