Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284542AbRLRSn1>; Tue, 18 Dec 2001 13:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284545AbRLRSl4>; Tue, 18 Dec 2001 13:41:56 -0500
Received: from m851-mp1-cvx1c.edi.ntl.com ([62.253.15.83]:21230 "EHLO
	pinkpanther.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S284484AbRLRSkP>; Tue, 18 Dec 2001 13:40:15 -0500
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200112181508.fBIF8Rs15880@pinkpanther.swansea.linux.org.uk>
Subject: Re: [CFT][PATCH] watchdog nowayout and timeout module parameters
To: mdomsch@lists.us.dell.com (Matt Domsch)
Date: Tue, 18 Dec 2001 15:08:27 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, alan@redhat.com, kenji@bitgate.com,
        nils@kernelconcepts.de, fuganti@conectiva.com.br,
        giometti@ascensit.com, support@ascensit.com, pb@nexus.co.uk,
        chowes@vsol.net, gorgo@itc.hu, info@itc.hu, lethal@chaoticdreams.org,
        woody@netwinder.org, johnsonm@redhat.com
In-Reply-To: <Pine.LNX.4.33.0112171116140.19932-100000@localhost.localdomain> from "Matt Domsch" at Dec 17, 2001 12:32:59 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> To the following drivers was also added a 'timeout=X' module parameter,
> where timeout is specified in seconds.  Only drivers for which no
> similar parm was already present were modified:

Timeout has been moved to an ioctl more by other diffs so Im not sure
timeout= is too important

Rest looks good

