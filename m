Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264946AbSJ3XiR>; Wed, 30 Oct 2002 18:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264955AbSJ3XiR>; Wed, 30 Oct 2002 18:38:17 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:31402 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S264946AbSJ3XiQ>; Wed, 30 Oct 2002 18:38:16 -0500
Subject: interrupt latency
From: Keith Adamson <keith.adamson@attbi.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Oct 2002 18:50:50 -0500
Message-Id: <1036021851.9791.12.camel@x1-6-00-d0-70-00-74-d1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen people use realfeel.c to measure interrupt latency 
on a system.  Most recently in an article at;

http://www.linuxjournal.com//article.php?sid=6405

But this program only measures interrupt jitter.  Is there 
a good test program somewhere that will test true interrupt 
latency?



