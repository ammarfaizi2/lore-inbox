Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935225AbWK1O3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935225AbWK1O3t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 09:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935221AbWK1O3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 09:29:49 -0500
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:9393 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S935225AbWK1O3t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 09:29:49 -0500
X-OB-Received: from unknown (205.158.62.49)
  by wfilter.us4.outblaze.com; 28 Nov 2006 14:29:48 -0000
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
From: spynet@usa.com
To: linux-kernel@vger.kernel.org
Date: Tue, 28 Nov 2006 11:29:50 -0300
Subject: A Big bug with ethernet card
X-Originating-Ip: 201.24.175.152
X-Originating-Server: ws1-1.us4.outblaze.com
Message-Id: <20061128142950.67A461BF297@ws1-1.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I find a bug in kernel 2.6.18.3

with ethernet card:
4.1 Ethernet card
    -- Networking support
        Networking options -->
            Ethernet (1000 Mbit) -->
                 Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller 

There are problems with ethernet card when booting to different system, e.g. from linux to M$ win - system is not able to connect to network. instead of re-boot you have to shutdown box and after that turn on. 

I running slackware 11 with kernel 2.6.18.3

root@segfault:/home/buzz# uname -a
Linux segfault 2.6.18.3 #2 Tue Nov 28 08:10:19 BRST 2006 i686 athlon-4 i386 GNU/Linux

this problem have someone patch?





-- 

Search for products and services at: 
http://search.mail.com

