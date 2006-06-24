Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWFXSA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWFXSA5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 14:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWFXSA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 14:00:57 -0400
Received: from rooties.de ([83.246.114.58]:27299 "EHLO rooties.de")
	by vger.kernel.org with ESMTP id S1751002AbWFXSA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 14:00:56 -0400
From: Daniel <damage@rooties.de>
To: linux-kernel@vger.kernel.org
Subject: Kernelsources writeable for everyone?!
Date: Sat, 24 Jun 2006 20:00:50 +0200
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606242000.51024.damage@rooties.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
may be this was reported/asked 999999999 times, but here ist the 1000000000th:

I have downloaded linux-2.6.17.1 10 min ago and I noticed that every file is 
writeable by everyone. What's going on there?

coffee src # tar -jtvf linux-2.6.17.1.tar.bz2
drwxrwxrwx git/git           0 2006-06-20 11:31:55 linux-2.6.17.1/
-rw-rw-rw- git/git         462 2006-06-20 11:31:55 linux-2.6.17.1/.gitignore
-rw-rw-rw- git/git       18693 2006-06-20 11:31:55 linux-2.6.17.1/COPYING
-rw-rw-rw- git/git       89536 2006-06-20 11:31:55 linux-2.6.17.1/CREDITS
drwxrwxrwx git/git           0 2006-06-20 11:31:55 
linux-2.6.17.1/Documentation/
-rw-rw-rw- git/git       10581 2006-06-20 11:31:55 
linux-2.6.17.1/Documentation/00-INDEX
[...]


regards
Daniel Buschke
