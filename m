Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTFCV4a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 17:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbTFCV4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 17:56:30 -0400
Received: from post-21.mail.nl.demon.net ([194.159.73.20]:55825 "EHLO
	post-21.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S261292AbTFCV43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 17:56:29 -0400
Message-ID: <3EDD1C87.5090906@maatwerk.net>
Date: Wed, 04 Jun 2003 00:09:11 +0200
From: Mauk van der Laan <mauk.lists@maatwerk.net>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: siimage slow on 2.4.21-rc6-ac2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just tested the siimage driver in 2.4.21-rc6-ac2. The errors i get in 
-rc6 have disappeared but
the computer becomes unresponsive (20 seconds between screen switches) 
when I run bonnie
and the disk is very slow:

I do hdparm -d1 -X66. Anything else I can try?

Mauk



