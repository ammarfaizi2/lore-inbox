Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261810AbTCLRZb>; Wed, 12 Mar 2003 12:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261805AbTCLRYH>; Wed, 12 Mar 2003 12:24:07 -0500
Received: from 203-195-201-27.now-india.net.in ([203.195.201.27]:34246 "HELO
	rvce.ac.in") by vger.kernel.org with SMTP id <S261804AbTCLRYE>;
	Wed, 12 Mar 2003 12:24:04 -0500
Message-ID: <20030312173613.29024.qmail@rvce.ac.in>
From: vinay@rvce.ac.in
To: linux-kernel@vger.kernel.org
Cc: "linux-bangalore-technical@yahoogroups.com" 
	<linux-bangalore-technical@yahoogroups.com>
Reply-To: vinay@rvce.ac.in
Subject: linux 2.4.20 with IMQ crashes 
Date: Wed, 12 Mar 2003 23:06:13 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I downloaded the 2.4.20 kernel and IMQ patch and compiled it and installed 
on the server which is a gateway which is installed with RH 8.0. The machine 
runs Squid, squidGuard, named, dhcpd, nntp and iptables firewall.
Then I configured the IMQ device using TC to do some bandwidth management. 
I'm using u32 filter. But after sometime
when the load increases it crashes. Without TC qdiscs active its stable. 
What can be the reasons? How to take kernel OOPS and
generate useful bug report? has anyone suffered from these symptoms?
TIA,
 --
Vinay Y S,
Computer Science Department,
R V College of Engineering,
Bangalore,
INDIA 
