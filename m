Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132118AbRCVRa5>; Thu, 22 Mar 2001 12:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132114AbRCVRar>; Thu, 22 Mar 2001 12:30:47 -0500
Received: from cpe.atm0-0-0-180310.boanxx4.customer.tele.dk ([62.243.2.100]:34998
	"HELO marvin.athome.dk") by vger.kernel.org with SMTP
	id <S132118AbRCVRag>; Thu, 22 Mar 2001 12:30:36 -0500
Message-ID: <3ABA3690.8040708@fugmann.dhs.org>
Date: Thu, 22 Mar 2001 18:29:52 +0100
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2 i686; en-US; 0.8.1) Gecko/20010314
X-Accept-Language: en
MIME-Version: 1.0
To: Jerome Tollet <Jerome.Tollet@qosmos.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.2 network performances
In-Reply-To: <3AB08FAC.657784CA@qosmos.net> <3AB9366E.3060905@fugmann.dhs.org> <3AB9C083.C093769F@qosmos.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

I've written my own test program, and I get 12M throughput.

I used a packet size of 1024 Bytes. Smaller packages seems to result in 
less throughput.

There was no load on the machine I tested on. Does the throughput get 
better is there is a lot of stress on the machine? (eg. compiling kernel 
with -j 10).

It could also be the NIC itself, but this I cannot test (I'm using a 
3Com 905b) card. Have you tried to replace the NIC?


-- 
Hi. I'm a .signature virus.
Please copy me into your .signature file and help me spread.

