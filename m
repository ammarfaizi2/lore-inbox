Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261671AbSJMTkP>; Sun, 13 Oct 2002 15:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261670AbSJMTkP>; Sun, 13 Oct 2002 15:40:15 -0400
Received: from [157.182.194.151] ([157.182.194.151]:62415 "EHLO
	mail.csee.wvu.edu") by vger.kernel.org with ESMTP
	id <S261669AbSJMTkN>; Sun, 13 Oct 2002 15:40:13 -0400
Subject: Sparc memory manipulation functions in 2.4.18
From: Shanti Katta <katta@csee.wvu.edu>
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Oct 2002 15:58:07 -0400
Message-Id: <1034539088.16630.20.camel@indus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to compile user-mode-linux-2.4.18-22 on Ultra Sparc using
gcc-3.2, I get undefined references to __builtin_memcpy,
__builtin_memset, __memcpy, __memset. I guess implementations to those
functions should be provided by gcc itself. Any ideas on what might be
wrong here?

-Shanti 



