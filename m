Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290218AbSAaKlR>; Thu, 31 Jan 2002 05:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290521AbSAaKlH>; Thu, 31 Jan 2002 05:41:07 -0500
Received: from [203.199.83.148] ([203.199.83.148]:1422 "HELO
	mailweb24.rediffmail.com") by vger.kernel.org with SMTP
	id <S290218AbSAaKlB> convert rfc822-to-8bit; Thu, 31 Jan 2002 05:41:01 -0500
Date: 31 Jan 2002 10:40:04 -0000
Message-ID: <20020131104004.22915.qmail@mailweb24.rediffmail.com>
MIME-Version: 1.0
From: "Girish  Pujar" <gspujar@rediffmail.com>
Reply-To: "Girish  Pujar" <gspujar@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: multicast not working
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I have an application that sends a multicast. 
I am running some applications on different machines(same subnet mask). On one machine I donot receive the multicast (seen through tcpdump). However after adding

>ifconfig eht0 addmulti  

I start getting multicast (again I see through tcpdump )
Still my appilcation does not get multicast. 

Kindly help

Thanks
Girish
 

