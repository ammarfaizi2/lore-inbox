Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317884AbSGKTpT>; Thu, 11 Jul 2002 15:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317885AbSGKTpS>; Thu, 11 Jul 2002 15:45:18 -0400
Received: from mm02snlnto.sandia.gov ([132.175.109.21]:48903 "HELO
	mm02snlnto.sandia.gov") by vger.kernel.org with SMTP
	id <S317884AbSGKTpR>; Thu, 11 Jul 2002 15:45:17 -0400
X-Server-Uuid: 95b8ca9b-fe4b-44f7-8977-a6cb2d3025ff
Message-ID: <03781128C7B74B4DBC27C55859C9D73809840658@es06snlnt>
From: "Shipman, Jeffrey E" <jeshipm@sandia.gov>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: ioctl between user/kernel space
Date: Thu, 11 Jul 2002 13:48:00 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-Filter-Version: 1.8 (sass2426)
X-WSS-ID: 11333FDA3577993-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure if this is the right place to ask this, but
I have a question about ioctl(). I have a situation where
I need to parse a file and build a hash table out of the
information in user space. Then, I must pass that hash
table into my module that's in kernel space. My question 
is: is ioctl() the way to go about this? I really don't
know much about the function, but some people have mentioned
it to me as the way to pass information between user and
kernel space.

If anyone has advice on if this is the way to go about it
or how we could go about doing this would be greatly
appreciated. Also, if anyone knows of any websites which
may be helpful in this area, we'd appreciate that as
well.

Thanks.

Jeff Shipman - CCD
Sandia National Laboratories
(505) 844-1158 / MS-1372

