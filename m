Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269347AbUINOon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269347AbUINOon (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 10:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269357AbUINOom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 10:44:42 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:9381 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269347AbUINOol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 10:44:41 -0400
Message-ID: <6dd83da040914074469c4f521@mail.gmail.com>
Date: Tue, 14 Sep 2004 17:44:41 +0300
From: Kostadin Karaivanov <k.karaivanov@gmail.com>
Reply-To: Kostadin Karaivanov <k.karaivanov@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: less
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm slackware user
today I upgraded mu box to kernel 2.6.9-rc2
for surprize the command less stops to work
after displaying of exactly one screen output it exits with following

here is e example 
#man ip
...........................
Error executing formatting or display command.
System command /bin/bzip2 -c -d /usr/man/cat8/ip.8.bz2 | /usr/bin/less
-is exited with status 256.
root@larry:~#
