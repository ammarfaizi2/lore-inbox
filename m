Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278197AbRJ1Lzr>; Sun, 28 Oct 2001 06:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278206AbRJ1Lzh>; Sun, 28 Oct 2001 06:55:37 -0500
Received: from host213-122-131-210.btinternet.com ([213.122.131.210]:57326
	"EHLO firewall0.node0.idium.eu.org") by vger.kernel.org with ESMTP
	id <S278197AbRJ1LzY>; Sun, 28 Oct 2001 06:55:24 -0500
Message-ID: <045301c15fa7$c2809b70$1901a8c0@node0.idium.eu.org>
From: "David Flynn" <Dave@keston.u-net.com>
To: "linux kernel mailinglist" <linux-kernel@vger.kernel.org>
Subject: Via KT133 and 2.4.8 and a hard disk problem ?
Date: Sun, 28 Oct 2001 11:57:46 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All;

What is the status of the problems with the old KT133 and kernel 2.4.8 ?

I have a system here which looks to me as if its beginning to suffer from
HDD failure, just do anything with the disk for a while and you get disk {
busy } errors (and there is an 0x0d error code there somewhere) ... (oh, and
the HDD light reports no activity) normally, i would view this as a good
time to pull all the data off the drive and replace it.

However, i have noticed that the chipset used is the Via KT133, and am now
wondering if this is actually a HDD problem (i still am siding with this) or
a chipset problem.

You can guarantee the problem by just running badblocks -sv /dev/hda

and it will happen at some point, (not always the same place)

Can anyone offer any advice on this ?

Thanks,

Dave

