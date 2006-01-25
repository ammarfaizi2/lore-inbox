Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWAYO2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWAYO2O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 09:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWAYO2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 09:28:14 -0500
Received: from i5-7.dnslinks.net ([66.98.167.159]:16273 "HELO ip01-web5.net")
	by vger.kernel.org with SMTP id S1751172AbWAYO2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 09:28:13 -0500
Message-ID: <62509.203.101.38.164.1138199699.squirrel@66.98.166.28>
Date: Wed, 25 Jan 2006 14:34:59 -0000 (UTC)
Subject: reg: proble i am facing
From: balamurugan@sahasrasolutions.com
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hai all,

i am trying to compile svinit in my system , the following error message
will be displayed, please give the clarifiaction for the issue.

cc -g  svinit.o   -o svinit
svinit.o(.text+0x509): In function `execThroughSyslog':
/sample/svinit-0.1-1/svinit.c:233: undefined reference to `errno'
svinit.o(.text+0x659): In function `execCustomLogProgram':
/sample/svinit-0.1-1/svinit.c:284: undefined reference to `errno'
svinit.o(.text+0x75a): In function `execCustomLogLogger':
/sample/svinit-0.1-1/svinit.c:326: undefined reference to `errno'
collect2: ld returned 1 exit status
make: *** [svinit] Error 1

thanks
balamurugan.j


