Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S153947AbPFAUJV>; Tue, 1 Jun 1999 16:09:21 -0400
Received: by vger.rutgers.edu id <S153938AbPFAUHX>; Tue, 1 Jun 1999 16:07:23 -0400
Received: from night.wserv.com ([206.105.188.5]:2101 "EHLO night.wserv.com") by vger.rutgers.edu with ESMTP id <S153983AbPFAUEc>; Tue, 1 Jun 1999 16:04:32 -0400
Message-ID: <37544C46.C9A1AA12@wserv.com>
Date: Tue, 01 Jun 1999 17:10:30 -0400
From: Jordan Mendelson <jordy@wserv.com>
Organization: Web Services, Incorporated
X-Mailer: Mozilla 4.6 [en]C-CCK-MCD {WSI 1.0.0}  (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.rutgers.edu
Subject: XTP: A better TCP than TCP
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu


Hello all,

I was just reviewing http://www.mentat.com/xtp/xtp.html and
http://www.ca.sandia.gov/xtp/. XTP looks like a very interesting protocol. 

It provides all the features of TCP, plus built-in realiable multicasts, better
speed over networks with packet loss, better speed overall, maximum bandwidth
limiting built-in, and a few other features which make it noteworthy.

It appears that they have defined a few protocols over XTP already, including
SMTP and FTP. 
Is there any projects out there to add XTP to the standard linux kernel?


Jordan

--
Jordan Mendelson     : http://jordy.wserv.com
Web Services, Inc.   : http://www.wserv.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
