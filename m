Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273643AbRIQPhC>; Mon, 17 Sep 2001 11:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273644AbRIQPgp>; Mon, 17 Sep 2001 11:36:45 -0400
Received: from denise.shiny.it ([194.20.232.1]:46570 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S273643AbRIQPgh>;
	Mon, 17 Sep 2001 11:36:37 -0400
Message-ID: <XFMail.20010917173700.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <E15iy3X-00077o-00@the-village.bc.nu>
Date: Mon, 17 Sep 2001 17:37:00 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: linux-kernel@vger.kernel.org
Subject: Strange ps line
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From "ps axuw":

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
httpd     5020  0.0  0.0     0    0 ?        Z    16:46   0:00 [getcod.cgi <defunct>]
httpd     5022  0.0  0.0     0    0 ?        Z    16:46   0:00 [getcod.cgi <defunct>]
httpd     5025  0.0  0.0 589505315 0 ?       ZL   16:46   0:00 [getcod.cgi <defunct>]
httpd     5049  0.0  0.0     0    0 ?        Z    16:46   0:00 [getcod.cgi <defunct>]

That cgi doesn't lock memory and surely I don't have so much memory.


Bye.

