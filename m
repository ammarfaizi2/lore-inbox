Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263805AbREYQrn>; Fri, 25 May 2001 12:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263804AbREYQrd>; Fri, 25 May 2001 12:47:33 -0400
Received: from smtp-server1.cfl.rr.com ([65.32.2.68]:32405 "EHLO
	smtp-server1.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S263798AbREYQr2>; Fri, 25 May 2001 12:47:28 -0400
Message-ID: <3B0E8B9F.CFBEAC59@evcom.net>
Date: Fri, 25 May 2001 12:43:11 -0400
From: Randy <randys@evcom.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Dedicated Interrupt handling on SMP
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to find the easiest way to to deidcate one CPU to responding
to a specific Interrupt request.
That CPU should only listen for that request while all other CPU should
ignore the interrupt.

Any suggestions? Do I have to muck with the IO_APIC or is there a
simpler way which I just missed?

Any help would be appreciated!

Thank you!

Randy Schumm
Please CC: answer to randys@evcom.net


