Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKHX2P>; Wed, 8 Nov 2000 18:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129029AbQKHX2F>; Wed, 8 Nov 2000 18:28:05 -0500
Received: from smtp1.ihug.co.nz ([203.109.252.7]:2053 "EHLO smtp1.ihug.co.nz")
	by vger.kernel.org with ESMTP id <S129033AbQKHX15>;
	Wed, 8 Nov 2000 18:27:57 -0500
Message-ID: <3A09E161.ACB11253@ihug.co.nz>
Date: Thu, 09 Nov 2000 12:27:29 +1300
From: david <sector2@ihug.co.nz>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: fpu now a must in kernel
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi i need fast fpu in the kernel for my lexos work
so how am i going to do it on the i386

1 . can i add some save / restore code to the task swicher ( the right
way )
     so when it switchs from user to kernel task its saves the fpu state
?

2 . put the save / restore code in my code (NOT! GOOD! i do not wont to
do it this way it is not the right way)

so i have to use fpu in the kernel so its just how am i going to do it ?

thank you

    David Rundle <sector2@ihug.co.nz>


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
