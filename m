Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129446AbRDAAGb>; Sat, 31 Mar 2001 19:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129624AbRDAAGV>; Sat, 31 Mar 2001 19:06:21 -0500
Received: from mclean.mail.mindspring.net ([207.69.200.57]:48182 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S129446AbRDAAGO>; Sat, 31 Mar 2001 19:06:14 -0500
Date: Sat, 31 Mar 2001 19:12:53 -0500
From: jerry <jdinardo@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: tcgetattr fails in 2.4.3
Message-ID: <20010331191253.A84@ix.netcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ppp chat script stopped working under 2.4.3. I ran a program of my own
that opens ttyS1 and it also fails on a tcgetattr with errno=5 (IO error).
The ppp chat script and my program both work fine under 2.4.2 and older.
jpd
