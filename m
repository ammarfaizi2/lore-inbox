Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267573AbUGWHhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267573AbUGWHhm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 03:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267574AbUGWHhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 03:37:42 -0400
Received: from web52905.mail.yahoo.com ([206.190.39.182]:45458 "HELO
	web52905.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267573AbUGWHhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 03:37:41 -0400
Message-ID: <20040723073740.76240.qmail@web52905.mail.yahoo.com>
Date: Fri, 23 Jul 2004 08:37:40 +0100 (BST)
From: =?iso-8859-1?q?Ankit=20Jain?= <ankitjain1580@yahoo.com>
Subject: i am working on mmx through gcc
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

well i am not able to understand the basic internal
functionality of assembly

suppose i use this command

movb %2,%0
:"=r"(a),"=r"(b)
:"r"(x)

now it will move the value of x in a but b is also
initialised with some value

what is actually happening internally

ankit

________________________________________________________________________
Yahoo! Messenger - Communicate instantly..."Ping" 
your friends today! Download Messenger Now 
http://uk.messenger.yahoo.com/download/index.html
