Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278375AbRJSMbq>; Fri, 19 Oct 2001 08:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278377AbRJSMbg>; Fri, 19 Oct 2001 08:31:36 -0400
Received: from [195.246.135.25] ([195.246.135.25]:2308 "EHLO
	chert.194.133.98.200") by vger.kernel.org with ESMTP
	id <S278375AbRJSMbS>; Fri, 19 Oct 2001 08:31:18 -0400
Date: Fri, 19 Oct 2001 16:30:58 +0200
From: Andrei Lahun <Uman@editec-lotteries.com>
To: linux-kernel@vger.kernel.org
Subject: problems with I/O performance with 2.4.12-ac3
Message-Id: <20011019163058.1bb7c6f7.uman@chert>
X-Mailer: Sylpheed version 0.6.3 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello.

I did a bonnie++ tests with 2.4.13-pre3(+aa vm)
 and 2.4.12-ac3(+Rick patch).
And i found that ac kernel have a big problems here.
With linux kernel i got 22 Mb/c for read 19 for write and
with ac  12 for read and 11 for write (both with ext2)
If i used ext3 with ac kernel results little bit better.
What is the reason for such regression in ac kernel ?
And yes of course i had udma for both test.

Andrei.
 
