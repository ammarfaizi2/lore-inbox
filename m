Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130673AbRALVia>; Fri, 12 Jan 2001 16:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132063AbRALViT>; Fri, 12 Jan 2001 16:38:19 -0500
Received: from femail1.rdc1.on.home.com ([24.2.9.88]:29924 "EHLO
	femail1.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S130673AbRALViE>; Fri, 12 Jan 2001 16:38:04 -0500
Message-ID: <3A5F791F.BCC236C1@Home.net>
Date: Fri, 12 Jan 2001 16:37:35 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Donald Becker <becker@scyld.com>, vortex@scyld.com,
        linux-kernel@vger.kernel.org
Subject: [PROBLEM]: Strange network problems with 2.4.0 and 3c59x.o
In-Reply-To: <Pine.LNX.4.10.10101020019010.8957-100000@vaio.greennet> <3A51D40F.48B9ADB9@home.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's something strange that i've been noticing with 2.4.0. Some websites I am
unable to access now. For example:

http://www.scotiabank.ca/simplify/index.html

if your in Canada and you have Scotia banking online, try and access their
banking sites. It will just hang. However upon trying the same in Windows 2000
(cough). The site works fine.

Could there be a network driver issue as even trying with telnet port 80 fails
as well?

Im not sure on this one this seems bizarre. I have the same problem with
www.workopolis.com, theglobeandmail.com, perhaps there's some sort of packet or
frame not being processed properly?

I can ICMP ping all the sites fine and i can access them from other shells.
I have spoken to some of their engineers and they say that there is nothing
blocking/no firewalls configured to deny access to theses sites.

If there's any information you need I'd be glad to try and figure this one out.

Shawn S.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
