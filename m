Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288484AbSAQLBn>; Thu, 17 Jan 2002 06:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288494AbSAQLBd>; Thu, 17 Jan 2002 06:01:33 -0500
Received: from port-213-20-128-120.reverse.qdsl-home.de ([213.20.128.120]:27660
	"EHLO drocklinux.dyndns.org") by vger.kernel.org with ESMTP
	id <S288484AbSAQLBZ> convert rfc822-to-8bit; Thu, 17 Jan 2002 06:01:25 -0500
Date: Thu, 17 Jan 2002 12:00:14 +0100 (CET)
Message-Id: <20020117.120014.730561837.rene.rebe@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Subject: O(1) scheduler-J0 on 2.4.17
From: Rene Rebe <rene.rebe@gmx.net>
X-Mailer: Mew version 2.1 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I just tried the sched-J0 patch for 2.4.17. I works great! The
interactive performance is back where it was with sched-G1. Even with
multiple gcc running I can move X11 windows arround very smothly! -
Thanks!

k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://drocklinux.dyndns.org/rene/

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
