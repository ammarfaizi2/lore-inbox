Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129780AbQLSNOS>; Tue, 19 Dec 2000 08:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130120AbQLSNN6>; Tue, 19 Dec 2000 08:13:58 -0500
Received: from unassigned.wayout.net ([163.121.142.10]:3539 "EHLO
	thewayout.net") by vger.kernel.org with ESMTP id <S129780AbQLSNNv>;
	Tue, 19 Dec 2000 08:13:51 -0500
From: khaled@pacificpost.com
Message-ID: <3A3F57A0.32A6F34D@pacificpost.com>
Date: Tue, 19 Dec 2000 14:42:08 +0200
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Presentation Layer in TCP/IP linux implementation
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linux World,

Is there a way to add a generic and transparent presenation layer in the
path of TCP/IP packets. I am speaking about something probably in the
path between the user space mechanims (send/recv/read/write) and the
actual sock_sendmsg/sock_recvmsg (and their proto counterparts).

Thanks for all replies.

Best regards

Khaled

PS: Please CC me on the replies since I am not a regular subscriber to
this list.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
