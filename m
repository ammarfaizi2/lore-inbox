Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261936AbREZOju>; Sat, 26 May 2001 10:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261948AbREZOja>; Sat, 26 May 2001 10:39:30 -0400
Received: from smtp-server2.cfl.rr.com ([65.32.2.69]:14558 "EHLO
	smtp-server2.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S261936AbREZOjV>; Sat, 26 May 2001 10:39:21 -0400
Message-ID: <3B0FBF11.21EB8F87@evcom.net>
Date: Sat, 26 May 2001 10:34:57 -0400
From: Randy <randys@evcom.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CPU Dedicated Interrupts
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the easiest way to tell a CPU to ignore certain interrupts from
module?
Is there an IRQ mask for each processor? Is that symbol exported?

Thank you!
Randy Schumm
Please all cc: randys@evcom.net

