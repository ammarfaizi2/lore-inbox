Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293326AbSCUFMm>; Thu, 21 Mar 2002 00:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293347AbSCUFMc>; Thu, 21 Mar 2002 00:12:32 -0500
Received: from web14510.mail.yahoo.com ([216.136.224.169]:21767 "HELO
	web14510.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S293326AbSCUFMU>; Thu, 21 Mar 2002 00:12:20 -0500
Message-ID: <20020321051219.9811.qmail@web14510.mail.yahoo.com>
Date: Wed, 20 Mar 2002 21:12:19 -0800 (PST)
From: Bergs <flygong@yahoo.com>
Subject: The network performance of linux
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 I work on a linux 2.2.14 kernel to test the network
throughput of a linux  box used as a firewall.

 I find that when the IP packet length is 512B,the
throughput is the highest 71%. IP packet length is
smaller than 512B or bigger than 512B,the throughput
is the lower.

   I don't know why this ? Can I have some solutions
to improve the throughput of linux box ?


                              Bergs



__________________________________________________
Do You Yahoo!?
Yahoo! Movies - coverage of the 74th Academy Awards®
http://movies.yahoo.com/
