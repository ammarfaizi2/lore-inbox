Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129397AbRAaDtB>; Tue, 30 Jan 2001 22:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129604AbRAaDsu>; Tue, 30 Jan 2001 22:48:50 -0500
Received: from [200.216.82.35] ([200.216.82.35]:24960 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S129397AbRAaDsg>; Tue, 30 Jan 2001 22:48:36 -0500
Date: Wed, 31 Jan 2001 01:48:24 -0200
From: Frédéric L. W. Meunier <0@pervalidus.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.1 with pppd 2.4.0: log problem
Message-ID: <20010131014824.E160@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.14i
X-Mailer: Mutt/1.3.14i - Linux 2.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. It worked without any problems with 2.4.0. Now with 2.4.1 I
don't get anymore the usual messages in /var/log/messages (like
pppd start and local and remote IP). The only change was the
addition of devfs, but I don't think it's causing this problem.
Any hints? I didn't change anything on my machine.

-- 
0@pervalidus.{net, {dyndns.}org} Tel: 55-21-717-2399 (Niterói-RJ BR)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
