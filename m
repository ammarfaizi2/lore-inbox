Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUGYPvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUGYPvA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 11:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUGYPvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 11:51:00 -0400
Received: from web25205.mail.ukl.yahoo.com ([217.12.10.65]:9823 "HELO
	web25205.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S264085AbUGYPu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 11:50:59 -0400
Message-ID: <20040725155058.13209.qmail@web25205.mail.ukl.yahoo.com>
Date: Sun, 25 Jul 2004 17:50:58 +0200 (CEST)
From: =?iso-8859-1?q?une=20pomme?= <trois_melons@yahoo.fr>
Subject: how to use system calls from user space
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I have some problems using system calls from kernel
space because they are acting like if data were given
from user space and can not retrieve them correctly.
so I have to recode system calls I want to use,
removing "getname" and "putname" functions (this way
it works ok).

Does it exist another way to call, for example,
"sys_open" from kernel space? Have I missed something?

thanks,

bye



	

	
		
Vous manquez d’espace pour stocker vos mails ? 
Yahoo! Mail vous offre GRATUITEMENT 100 Mo !
Créez votre Yahoo! Mail sur http://fr.benefits.yahoo.com/

Le nouveau Yahoo! Messenger est arrivé ! Découvrez toutes les nouveautés pour dialoguer instantanément avec vos amis. A télécharger gratuitement sur http://fr.messenger.yahoo.com
