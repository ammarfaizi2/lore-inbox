Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268350AbTBSK6C>; Wed, 19 Feb 2003 05:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268353AbTBSK6C>; Wed, 19 Feb 2003 05:58:02 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:40936 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S268350AbTBSK6B>; Wed, 19 Feb 2003 05:58:01 -0500
Message-ID: <3E53645B.3070809@blue-labs.org>
Date: Wed, 19 Feb 2003 06:02:51 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030209
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Linux v2.5.62 --- spontaneous reboots
References: <Pine.LNX.4.44.0302171752560.1754-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0302171752560.1754-100000@home.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 2.5.58 box that's a simple firewall/router w/ iptables running 
on it.  It crashes and reboots automatically roughly every other day.  
It's been doing that for a  long time and I never had the time to debug 
it.  I'll put .62 on it with a serial console and see what it comes up 
with.  It runs two PPPoE channels over ethX.  PPPoE is known to blow up 
(OOPS) on pppd hangup/restarts.

David


