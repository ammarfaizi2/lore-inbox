Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265833AbTGLOAr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 10:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265835AbTGLOAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 10:00:47 -0400
Received: from customer-mpls-23.cpinternet.com ([209.240.253.23]:4870 "EHLO
	mharnois.mdharnois.net") by vger.kernel.org with ESMTP
	id S265833AbTGLOAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 10:00:45 -0400
Subject: 2.4.22-pre5 and radeonfb
From: "Michael D. Harnois" <mharnois@cpinternet.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1058019328.21612.4.camel@michaelh>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 12 Jul 2003 09:15:28 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The -pre5 patch asks radeonfb.c to include linux/radeonfb.h, but no such
file exists.

-- 
Michael D. Harnois
3L, UST School of Law                   Minneapolis, Minnesota
 The first thing you should do when you get up is read the obituaries. 
 You never know when you'll see a name that will just make your day. 
     --Ed Salisbury

