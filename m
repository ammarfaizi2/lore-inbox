Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132296AbQLJTtI>; Sun, 10 Dec 2000 14:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132600AbQLJTs6>; Sun, 10 Dec 2000 14:48:58 -0500
Received: from rincewind.3dart.com.pl ([212.160.240.66]:64526 "EHLO
	rincewind.3dart.com") by vger.kernel.org with ESMTP
	id <S132296AbQLJTsr>; Sun, 10 Dec 2000 14:48:47 -0500
Message-ID: <3A33D5F9.D7CB8A41@3dart.com>
Date: Sun, 10 Dec 2000 20:14:01 +0100
From: Maciej Bogucki <bogucki@3dart.com>
Organization: 3dart.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test9 problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI!
 I have 2.4.0-test9 and 2.2.16 kernel compiled on my computer .I have
httpd server on this computer . With 2.2.16 apache work good ( via DSL
and modem ), but with 2.4 ( the same computer ) , when I wont to connect
to my page via modem first few kilobytes are downloaded "fast" and then
connection slow down and transfer rate is 1byte per second . When I
download this page from linux ( via modem ) everything is ok ! I have
this problem , when I want to see this this page from MS Windows
computers only via ppp connection . I have tested it on two different
computer and result is the same . 

I have seek this proble on mailing lists , but I haven't found . Have
anybody had the same problem like me ? 

Maciej Bogucki, Network Administrator
---
3dart.com / end-to-end solutions     http://www.3dart.com
Spolka Internetowa                   tel: (+48 22) 646 64 65
ul. Goszczynskiego 10                02-616, Warszawa
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
