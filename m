Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129486AbRCZWnj>; Mon, 26 Mar 2001 17:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129509AbRCZWn3>; Mon, 26 Mar 2001 17:43:29 -0500
Received: from river.it.gvsu.edu ([148.61.1.16]:46021 "EHLO river.it.gvsu.edu")
	by vger.kernel.org with ESMTP id <S129486AbRCZWnL>;
	Mon, 26 Mar 2001 17:43:11 -0500
Message-ID: <3ABFC5A7.8090202@lycosmail.com>
Date: Mon, 26 Mar 2001 17:41:43 -0500
From: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-ac20 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [OT] Sane Architectures
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are there any architectures that are simple (sane) to implement sftw on? 
The i386 is plagued by it's 16-bit (arguably its 8 or even 4 bit) past. 
The HP-PARISC has its brokenness, PPC isn't that great either from what 
I've heard. And the list goes on.

Now I will I admit that I am likely wrong, and can expect some flamage 
for this. This is intended as a curiousity about something decent.

This can include architectures like the IA64 & the upcoming x86-64. Just 
looking for something with lots of GPR's, sane MM support, etc.

Takers

(Borrowing asbestos suit from my uncle)

