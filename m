Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278842AbRJZTFw>; Fri, 26 Oct 2001 15:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278892AbRJZTFn>; Fri, 26 Oct 2001 15:05:43 -0400
Received: from lsd.nurk.org ([208.8.184.53]:37003 "HELO lsd.nurk.org")
	by vger.kernel.org with SMTP id <S278842AbRJZTFc>;
	Fri, 26 Oct 2001 15:05:32 -0400
Date: Fri, 26 Oct 2001 12:06:44 -0700 (PDT)
From: Sean Swallow <sean@swallow.org>
To: linux-kernel@vger.kernel.org
Subject: 3Com PCI 3c905C Tornado with later kernels
Message-ID: <Pine.LNX.4.40.0110261142110.1175-100000@lsd.nurk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

List,

I am having a problem with a 3c905C and later kernels (2.4.9, 2.4.12 and
2.4.13).  When I try to use my 3c905C with these kernels I get this error
message:

Cannot open netlink socket: Address family not supported by protocol

Kernel 2.4.7 works fine with this nic tho. I also tried this on another
machine with the same results.

Any suggestions?

thank you,

-- 
Sean J. Swallow
pgp (6.5.2) keyfile @ https://nurk.org/keyfile.txt


