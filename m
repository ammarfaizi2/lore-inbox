Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132577AbRDWXev>; Mon, 23 Apr 2001 19:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132575AbRDWXef>; Mon, 23 Apr 2001 19:34:35 -0400
Received: from mailhost.iworld.com ([63.95.15.3]:34464 "EHLO
	mailhost.iworld.com") by vger.kernel.org with ESMTP
	id <S132576AbRDWXe0>; Mon, 23 Apr 2001 19:34:26 -0400
Message-ID: <3AE4BBAA.C5A91413@internet.com>
Date: Mon, 23 Apr 2001 19:32:58 -0400
From: Byron Albert <balbert@internet.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: odd messages in dmesg (network I think)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
 I am getting odd message in my dmesg
I am running
Linux extreme 2.4.2-ac28 #1 SMP Fri Apr 13 01:58:47 UTC 2001 i686
unknown
and the messages look like


Undo Hoe 64.22.x.x/4414 c3 l2 ss10/65535 p4
Undo Hoe 64.22.x.x/4414 c3 l1 ss10/65535 p3
Undo Hoe 64.22.x.x/4414 c3 l1 ss10/65535 p2
Undo retrans 64.22.x.x/4414 c2 l0 ss10/65535 p0
Undo partial loss 64.157.x.x/32831 c1 l1 ss2/65535 p1
Disorder3 1 4 f4 s2 rr0
Disorder3 1 4 f4 s2 rr0
Disorder3 1 4 f4 s2 rr0
Undo loss 64.108.x.x/2786 c2 l0 ss2/65535 p0
Undo partial loss 200.27.x.x/2374 c1 l1 ss2/65535 p1
Undo partial loss 213.228.x..x/32936 c2 l1 ss2/65535 p1
Undo partial loss 213.228.x.x/32937 c2 l1 ss2/65535 p1
Disorder3 3 5 f6 s2 rr0
Disorder1 3 6 f0 s0 rr1
Undo Hoe 202.75.x.x/34237 c7 l0 ss4/65535 p6
Undo Hoe 202.75.x.x/34237 c7 l0 ss4/65535 p5
Undo retrans 202.75.x.x/34237 c6 l0 ss4/65535 p5

On my webserver errors like this fill the dmesg in a day. I did repalce
some ips with x.x.

Thanks for any info
Byron

