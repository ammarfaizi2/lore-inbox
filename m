Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266511AbUHYLuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266511AbUHYLuW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 07:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266900AbUHYLuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 07:50:22 -0400
Received: from web41501.mail.yahoo.com ([66.218.93.84]:39524 "HELO
	web41501.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266511AbUHYLuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 07:50:21 -0400
Message-ID: <20040825115020.58522.qmail@web41501.mail.yahoo.com>
Date: Wed, 25 Aug 2004 12:50:20 +0100 (BST)
From: =?iso-8859-1?q?Arne=20Henrichsen?= <ahenric@yahoo.com>
Subject: sys_sem* undefined
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am running kernel 2.6.8 and have noticed that in
linux/sem.h the function declarations for sys_semop,
sys_semop etc have been removed (as far as I can see
from 2.6.4 onwards). Now when I compile my code I get
the sys_sem* undefined warning messages. Which header
file do I need to include now to get this support? 

Also when I want to load my module with insmod it
cannot find these symbols.

Thanks for the help.
Arne


	
	
		
___________________________________________________________ALL-NEW Yahoo! Messenger - all new features - even more fun!  http://uk.messenger.yahoo.com
