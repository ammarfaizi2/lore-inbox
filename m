Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263545AbRFDQpu>; Mon, 4 Jun 2001 12:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264328AbRFDQRQ>; Mon, 4 Jun 2001 12:17:16 -0400
Received: from 202-54-39-145.tatainfotech.co.in ([202.54.39.145]:35076 "EHLO
	brelay.tatainfotech.com") by vger.kernel.org with ESMTP
	id <S264327AbRFDQRD>; Mon, 4 Jun 2001 12:17:03 -0400
Date: Mon, 4 Jun 2001 22:04:45 +0530 (IST)
From: "SATHISH.J" <sathish.j@tatainfotech.com>
To: linux-kernel@vger.kernel.org
Subject: Reg mkdir syscall
In-Reply-To: <Pine.LNX.4.10.10106031716330.3971-100000@blrmail>
Message-ID: <Pine.LNX.4.10.10106042157410.10477-100000@blrmail>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Sorry to disturb you.

Actually I had written a small file system(on 2.2.14 kernel) similar  to
RAMFS on 2.4 kernel. I am able to mount it but when I try to create
directory under it, it gives EEXIST error saying" file already exists" but
when I check the directory again that file gets created. But the link
count of the parent remains the same. I do not know how this directory
gets created but with an error message. Please also tell me what all
functions mkdir passes thro' while creating a directory. One more thing is
when I took an strace of mkdir command the syscall mkdir fails with
EEXIST error.
Please help me with your thoughts.

Thanks in advance,

Regards,
sathish.j




