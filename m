Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155908AbQD1P5m>; Fri, 28 Apr 2000 11:57:42 -0400
Received: by vger.rutgers.edu id <S155537AbQD1Pxa>; Fri, 28 Apr 2000 11:53:30 -0400
Received: from web1610.mail.yahoo.com ([128.11.23.164]:2806 "HELO web1610.mail.yahoo.com") by vger.rutgers.edu with SMTP id <S155534AbQD1Pr5>; Fri, 28 Apr 2000 11:47:57 -0400
Message-ID: <20000428155437.8107.qmail@web1610.mail.yahoo.com>
Date: Fri, 28 Apr 2000 08:54:37 -0700 (PDT)
From: Sujit Vaidya <svaidya75@yahoo.com>
Subject: Delaying eth0 Initialization
To: linux <linux-kernel@vger.rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-kernel@vger.rutgers.edu


 Hi,
    I have installed Red Hat 5.1 on my 486 machine.
It boots up fine with linux kernel and communicates
well  with the network through eth0.
    Now I compiled the kernel with a prink statement
in  the /net/ipv4/ip_input.c file. Now when i boot the
compiled kernel it says while booting
 
 Delaying eth0 initialization.
 
 If you try ifconfig eth0 interface doesn't show up.
 I have 3com 3c59x card

 
 
 Any suggestions
 
 SUJIT
 
 
 __________________________________________________
> Do You Yahoo!?
> Talk to your friends online and get email alerts
> with Yahoo! Messenger.
> http://im.yahoo.com/
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.rutgers.edu
> Please read the FAQ at http://www.tux.org/lkml/

__________________________________________________
Do You Yahoo!?
Talk to your friends online and get email alerts with Yahoo! Messenger.
http://im.yahoo.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
