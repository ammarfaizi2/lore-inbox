Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268133AbTCFQuP>; Thu, 6 Mar 2003 11:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268140AbTCFQuP>; Thu, 6 Mar 2003 11:50:15 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:22753 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S268133AbTCFQuO>; Thu, 6 Mar 2003 11:50:14 -0500
Date: Thu, 6 Mar 2003 12:00:10 -0500
From: daveman@bellatlantic.net
To: linux-kernel@vger.kernel.org
Subject: Zombie processes with mozilla loading java applets 2.5.60-2.5.64
Message-ID: <20030306170010.GB2078@bellatlantic.net>
Reply-To: daveman@bellatlantic.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [157.182.138.149] at Thu, 6 Mar 2003 11:00:42 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since about 2.5.60, I've noticed when loading java applets in Mozilla, sometimes they fail to load and create a zombie process. Killing Mozilla and restarting the java applets usually fixes the problem, but this is easily reproducible. This does not occur in 2.4.20. Java version is 'Sun JDK 1.4.1', compiled locally against 'GCC 3.2.2'. I haven't found anything in the archives about this. Please let me know if I can be of further assistance.

Regards,
David Shepard

-- 
