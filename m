Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266851AbSKUSNl>; Thu, 21 Nov 2002 13:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266928AbSKUSNl>; Thu, 21 Nov 2002 13:13:41 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:45738 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266851AbSKUSNk> convert rfc822-to-8bit; Thu, 21 Nov 2002 13:13:40 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Where is ext2/3 secure delete ("s") attribute?
Date: Thu, 21 Nov 2002 19:20:07 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Kent Borg <kentborg@borg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211211920.07414.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kent,

> What happened to this feature?  Was it too slow or buggy?  Did the
> Federales force its removal?
dunno, but:

man 1 chattr:

BUGS AND LIMITATIONS
       As  of  Linux  2.2,  the  `c',  's',  and `u' attribute are not honored
       by the kernel filesystem code. These attributes will be implemented in
       a future ext2 fs version.

Curious to see when the future is ;)

ciao, Marc
