Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129290AbRBIVL5>; Fri, 9 Feb 2001 16:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130055AbRBIVLs>; Fri, 9 Feb 2001 16:11:48 -0500
Received: from [210.212.54.4] ([210.212.54.4]:22533 "EHLO mail.cse.iitk.ac.in")
	by vger.kernel.org with ESMTP id <S129290AbRBIVLl>;
	Fri, 9 Feb 2001 16:11:41 -0500
Date: Sat, 10 Feb 2001 02:35:05 +0530 (IST)
From: Ashish Gupta <gashish@cse.iitk.ac.in>
To: gashish@cse.iitk.ac.in
cc: kernelnewbies@humbolt.nl.linux.org, linux-kernel@vger.kernel.org
Subject: problem in BOGOmips
In-Reply-To: <3A6C802C.9380961A@earthlink.net>
Message-ID: <Pine.LNX.4.04.10102100210150.12228-100000@csews12.cse.iitk.ac.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I want to use bogomips as the indicator of CPU capability for
different architectures. I have found following values from /proc/cpuinfo
for different CPUs.

	MHz		bogomips version
	233 intel	233	 2.2.9, 2.0.36
	166 intel	331	 2.2.9
	450 AMD-K6	900	 2.2.14
	800 intel	1600	 2.2.16

Why there is a exceptional behaviour of bogomips for 233 intel ?
If there is some patch or changes then please indicate so that i can use
it. 

Thanks in advance
Ashish Gupta




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
