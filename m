Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132959AbRDLOVJ>; Thu, 12 Apr 2001 10:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132983AbRDLOVA>; Thu, 12 Apr 2001 10:21:00 -0400
Received: from ns1.justnet.com ([64.245.23.22]:23300 "EHLO ns1.justnet.com")
	by vger.kernel.org with ESMTP id <S132959AbRDLOUt>;
	Thu, 12 Apr 2001 10:20:49 -0400
From: Lee Leahu <lee@ricis.com>
Reply-To: lee@ricis.com
Organization: RICIS Inc
To: alansz@uic.edu, linux-kernel@vger.kernel.org, linux-admin@vger.kernel.org,
        linux-net@vger.kernel.org
Subject: nating on linux
Date: Thu, 12 Apr 2001 09:19:56 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01041209195606.00893@linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have two network connections.

one is to my company with the lan useing the 192.168.0.0 subnet,
and the other is to a client using the same subnet.

i wanted to know if it was possible to setup some kind of nating on my laptop 
in such a way, that will translate the client's entire 192.168.0.0 subnet 
into a 10.168.0.0 subnet on by laptop.

i printed the man pages for ipchains, but i'm not sure how and where
to start.

if anyone can help, that would be appreciated.

i'm runing SuSE 7.1 2.4.0-4GB kernel on my ibm 600E latop.
-- 
Lee Leahu <lee@ricis.com>,
System Admin,
Web Developer,
RICIS Inc,
(708) 444-2690 (Work)
(708) 467-2044 (Pager)
