Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319720AbSIMRfA>; Fri, 13 Sep 2002 13:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319723AbSIMRfA>; Fri, 13 Sep 2002 13:35:00 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:23707 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S319720AbSIMRe7>; Fri, 13 Sep 2002 13:34:59 -0400
Date: Fri, 13 Sep 2002 10:39:18 -0700
From: " Jim Sibley" <jimsibley@earthlink.net>
To: pollard@admin.navo.hpc.mil
Cc: linux-kernel@vger.kernel.org, riel@conectiva.com.br,
       vda@port.imtp.ilyichevsk.odessa.ua, alan@lxorguk.ukuu.org.uk
Reply-To: jimsibley@earthlink.net
Subject: [No Subject]
Message-ID: <Springmail.0994.1031938758.0.73924900@webmail.pas.earthlink.net>
X-Originating-IP: 32.97.110.142
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, please change your replies to me to jimsibley@earthlink.net and drop
the IBM address. Some of my replies may not reflect IBM's position. 

Also please drop the LTC address in your replies. I'm told that the address is
not a
place to discuss issues like this. So much for monolithic turf wars.

Anyway, back to the important stuff.

GID might be sufficient if you reserve some GID for resource balancing and use
the /proc interface to update it.

As Thunder has pointed out, what do you do when all thatis left is critical
system stuff?

What I wouldn't want to see is a cumbersome workload manager ala zOS that
might consume as much resources as its tring to manage. Nor should the
solution be too extotic that other Unix might adopt.

