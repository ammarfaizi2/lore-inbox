Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284054AbRLELLs>; Wed, 5 Dec 2001 06:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284053AbRLELLk>; Wed, 5 Dec 2001 06:11:40 -0500
Received: from sunfish.linuxis.net ([64.71.162.66]:746 "HELO
	sunfish.linuxis.net") by vger.kernel.org with SMTP
	id <S284054AbRLELLd>; Wed, 5 Dec 2001 06:11:33 -0500
Date: Wed, 5 Dec 2001 03:06:53 -0800
To: linux-kernel@vger.kernel.org
Subject: Maximum heap size?
Message-ID: <20011205030653.F15577@flounder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.21i
X-Delivery-Agent: TMDA v0.42/Python 2.1.1 (sunos5)
From: "Adam McKenna" <adam-dated-1007982419.3acea7@flounder.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been STFW'ing for a few hours now and I keep finding conflicting
reports on what the maximum heap size is with Linux 2.4.  Some places say it
is 1GB, and others say it is unlimited.

Background:  We have a java process that dies if the -mx flag passed to java
is more than 1GB.  Our developers say it is a Linux bug (since we don't
have the same problem on Solaris).  We are using Sun J2SE/JDK 1.3.1.

Any clarification would be appreciated.

Thanks,

--Adam
