Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315780AbSEDGb4>; Sat, 4 May 2002 02:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315781AbSEDGbz>; Sat, 4 May 2002 02:31:55 -0400
Received: from web8103.in.yahoo.com ([203.199.70.30]:4882 "HELO
	web8103.in.yahoo.com") by vger.kernel.org with SMTP
	id <S315780AbSEDGbz>; Sat, 4 May 2002 02:31:55 -0400
Message-ID: <20020504063150.79973.qmail@web8103.in.yahoo.com>
Date: Sat, 4 May 2002 07:31:50 +0100 (BST)
From: =?iso-8859-1?q?nimeesh=20patel?= <nimeesh_divi@yahoo.co.in>
Subject: strange ARP request
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi
i'm using redhat7.0.
In that i found that this system is sending ARP
request after some interval which is point to point
instead of broadcast...
Is this bcoz' of any daemon or is it bug on my system
or it is common behaviour of linux system...
Generally i observed that is sends 3 packets in one
minute which are point to point to that system and not
normal broadcast...
One problem i found is nameserver entry was wrong in
resolv.conf ,after changing it it just reduced the not
of packet sends...



________________________________________________________________________
For live cricket scores download  Yahoo! Score Tracker
 at: http://in.sports.yahoo.com/cricket/tracker.html
