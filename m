Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131224AbQJ1SvK>; Sat, 28 Oct 2000 14:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131231AbQJ1SvA>; Sat, 28 Oct 2000 14:51:00 -0400
Received: from ausxc08.us.dell.com ([143.166.99.216]:19771 "EHLO
	ausxc08.us.dell.com") by vger.kernel.org with ESMTP
	id <S131224AbQJ1Sur>; Sat, 28 Oct 2000 14:50:47 -0400
Message-ID: <CDF99E351003D311A8B0009027457F1403BF982E@ausxmrr501.us.dell.com>
From: Matt_Domsch@Dell.com
To: Daniel.Deimert@intermec.com
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: RE: PROBLEM: DELL PERC/Megaraid RAID driver in Linux 2.2.18pre17 
	hang
Date: Sat, 28 Oct 2000 13:50:37 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't believe that v1.09 (as in Red Hat Linux 7) has this problem, but
does have fixes over-and-above 1.07 (particularly, 1.07 and v1.08 touch
user-space inappropriately, 1.09 fixes).  If PeterJ can't get to it before
2.2.18final, Alan, would you consider putting in the v1.09 driver?

Thanks,
Matt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
