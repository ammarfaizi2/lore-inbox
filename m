Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316994AbSFWIMV>; Sun, 23 Jun 2002 04:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316995AbSFWIMU>; Sun, 23 Jun 2002 04:12:20 -0400
Received: from m206-234.dsl.tsoft.com ([198.144.206.234]:8361 "EHLO
	jojda.2y.net") by vger.kernel.org with ESMTP id <S316994AbSFWIMU>;
	Sun, 23 Jun 2002 04:12:20 -0400
Message-ID: <3D1582E4.7016EA1F@bigfoot.com>
Date: Sun, 23 Jun 2002 01:12:20 -0700
From: Erik Steffl <steffl@bigfoot.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en, sk, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: non-killable program - kernel problem?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  cleanup (part of postfix) is eating up most of CPU cycles and I cannot
kill it (-9 is ignored) - I guess that means that the problem is
somewhere in kernel (system call). Is it true? Is there anything I can
do to kill it? to find out what the problem is?

  I attached gdb to it but now gdb is stuck as well... I didn't see
anything suspicious in system log...

  kernel 2.4.18, I didn't upgrade it for a long time and this cleanup
problem only occured recently (last few weeks, twice).

  TIA

	erik
