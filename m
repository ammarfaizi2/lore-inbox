Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261258AbSI3TBG>; Mon, 30 Sep 2002 15:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261283AbSI3TBG>; Mon, 30 Sep 2002 15:01:06 -0400
Received: from hermes.kos.net ([199.246.2.125]:14561 "HELO hermes.kos.net")
	by vger.kernel.org with SMTP id <S261258AbSI3TBF> convert rfc822-to-8bit;
	Mon, 30 Sep 2002 15:01:05 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Steve Cole <coles@kos.net>
Organization: Kingston Online Services
To: linux-kernel@vger.kernel.org
Subject: *.20pre8-ac2 compile fails on SPARC
Date: Mon, 30 Sep 2002 15:14:15 -0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209301514.15752.coles@kos.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-- cut

sched.c: In function `schedule':
sched.c:950: warning: implicit declaration of function `_sched_find_first_bit'
sched.c:962: parse error before ';' token
sched.c: In function `show_task':
sched.c:1653: warning: implicit declaration of function `__ffs'

-- cut
