Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263346AbRFRVpE>; Mon, 18 Jun 2001 17:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263358AbRFRVoz>; Mon, 18 Jun 2001 17:44:55 -0400
Received: from isimail.interactivesi.com ([207.8.4.3]:45841 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S263346AbRFRVoh>; Mon, 18 Jun 2001 17:44:37 -0400
Date: Mon, 18 Jun 2001 16:44:28 -0500
From: Timur Tabi <ttabi@interactivesi.com>
To: linux-kernel@vger.kernel.org
Subject: What happened to lookup_dentry?
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-ID: <PD1Rx.A.X-F.-YnL7@dinero.interactivesi.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm porting a driver from 2.2 to 2.4, and this driver calls lookup_dentry,
which doesn't exist in 2.4.  I've read through the source code and searched the
web and newsgroups, and I can't find any explanation as to why lookup_dentry no
longer exists or how I'm supposed to change code that uses it.  Can anyone help
me?


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

