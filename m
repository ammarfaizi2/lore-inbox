Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287115AbSALPfc>; Sat, 12 Jan 2002 10:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287134AbSALPfZ>; Sat, 12 Jan 2002 10:35:25 -0500
Received: from 24-196-120-102.fdl.wi.charter.com ([24.196.120.102]:9353 "EHLO
	ryoko.kuiki.net") by vger.kernel.org with ESMTP id <S287115AbSALPfK>;
	Sat, 12 Jan 2002 10:35:10 -0500
Date: Sat, 12 Jan 2002 09:35:10 -0600
From: hachi@kuiki.net
To: linux-kernel@vger.kernel.org
Subject: netlink sockets in 2.4.17
Message-ID: <20020112153510.GB22133@ryoko.kuiki.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am looking for what happened to the netlink sockets in the 2.4 series 
kernels (I'm screwing around with 2.4.17) As far as I can tell I need 
these to run Zebra (bgpd)

My query is this, when and why were netlink sockets removed from 2.4,
while netlink devices were left in there? and why was this not included
in a Changelog at any point?

Thanks for your time,
Jonathan Steinert
