Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273295AbRINExr>; Fri, 14 Sep 2001 00:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273294AbRINExi>; Fri, 14 Sep 2001 00:53:38 -0400
Received: from [216.6.80.34] ([216.6.80.34]:12814 "EHLO
	dcmtechdom.dcmtech.co.in") by vger.kernel.org with ESMTP
	id <S273295AbRINExY>; Fri, 14 Sep 2001 00:53:24 -0400
Message-ID: <7FADCB99FC82D41199F9000629A85D1A01C65269@dcmtechdom.dcmtech.co.in>
From: Nitin Dhingra <nitin.dhingra@dcmtech.co.in>
To: "'spamtrap@spinics.net'" <spamtrap@spinics.net>,
        linux-kernel@vger.kernel.org
Subject: RE: iSCSI support for Linux??
Date: Fri, 14 Sep 2001 10:25:20 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UNH is faking on the server side and moreover it is not supporting
any security.

- Nitin

 -----Original Message-----
From: 	spamtrap@spinics.net [mailto:spamtrap@spinics.net] 
Sent:	Thursday, September 13, 2001 3:38 PM
To:	linux-kernel@vger.kernel.org
Subject:	Re: iSCSI support for Linux??

In article <017401c13c61$9fc5d000$0a02a8c0@consensys.com> you write:

>I am also investigating the iSCSI stuff now, and focusing on the server
>side. I found most implementors have no support to authentication and
>security. That's the reason why I prefer to the Cisco one, which support
>CHAP authentication. But I can't find the server code in their site,
>http://sourceforge.net/projects/linux-iscsi/, only the driver and daemon on
>client side here. So can you tell me where I can get a linux server code
>matching this client?

Have you tried the code from UNH?

  http://www.cs.uml.edu/~mbrown/iSCSI/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
