Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130149AbRAZDaF>; Thu, 25 Jan 2001 22:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130207AbRAZD34>; Thu, 25 Jan 2001 22:29:56 -0500
Received: from mailout2-1.nyroc.rr.com ([24.92.226.165]:55981 "EHLO
	mailout2-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S130149AbRAZD3i>; Thu, 25 Jan 2001 22:29:38 -0500
Message-ID: <3A70EF20.1B02B307@rochester.rr.com>
Date: Thu, 25 Jan 2001 22:29:36 -0500
From: Mark Bratcher <mbratche@rochester.rr.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.0 loop device still hangs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I saw a post dated last fall 2000 sometime about the loop device hanging
when copying large amounts of data to a file mounted as, say, ext2fs. It
was in regard to kernel 2.4.0test-something.

I have the latest 2.4.0 kernel loaded on my system and this bug appears
to be there, although I have seen other notes that claim that it is
fixed.

Can anyone confirm whether this bug is "officially" known to be in the
official 2.4.0 kernel? Currently I have to reboot to 2.2.17 to do my
CD-RW backups.

Thanks.
-- 
Mark Bratcher
mailto:mbratche@rochester.rr.com
---------------------------------------------------------
Escape from Microsoft's proprietary tentacles: use Linux!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
