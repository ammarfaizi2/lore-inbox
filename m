Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267435AbUGWHyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267435AbUGWHyq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 03:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267439AbUGWHyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 03:54:46 -0400
Received: from web52902.mail.yahoo.com ([206.190.39.179]:59740 "HELO
	web52902.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267435AbUGWHyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 03:54:45 -0400
Message-ID: <20040723075445.56108.qmail@web52902.mail.yahoo.com>
Date: Fri, 23 Jul 2004 08:54:45 +0100 (BST)
From: =?iso-8859-1?q?Ankit=20Jain?= <ankitjain1580@yahoo.com>
Subject: working with mmx
To: linux <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

actually the problem is i am not able to understand
why this is not functiuoning

asm("mov %2,%0"
    "mov %3,%1"
    :"=r"(x),"=r"(y)
    :"r"(a),"r"(b))

it gives assembler error

ankit 

________________________________________________________________________
Yahoo! Messenger - Communicate instantly..."Ping" 
your friends today! Download Messenger Now 
http://uk.messenger.yahoo.com/download/index.html
