Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143630AbRA1Vql>; Sun, 28 Jan 2001 16:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144242AbRA1Vqb>; Sun, 28 Jan 2001 16:46:31 -0500
Received: from omega.cisco.com ([171.69.63.141]:55708 "EHLO cisco.com")
	by vger.kernel.org with ESMTP id <S143552AbRA1VqW>;
	Sun, 28 Jan 2001 16:46:22 -0500
Message-Id: <4.3.2.7.2.20010129084117.02ae4f00@171.69.63.141>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 29 Jan 2001 08:45:32 +1100
To: Dax Kelson <dax@gurulabs.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: ECN fixes for Cisco gear
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0101281429140.6934-100000@ultra1.inconnect.c
 om>
In-Reply-To: <20010128151835.G13195@xi.linuxpower.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At 02:33 PM 28/01/2001 -0700, Dax Kelson wrote:
>Here is the fix for PIX:
>
>(see
>http://www.cisco.com/cgi-bin/Support/Bugtool/onebug.pl?bugid=CSCds23698)
>     Bud ID: CSCds23698
>     Headline: PIX sends RSET in response to tcp connections with ECN
>  bits set
>     Product: PIX
>     Component: fw
>     Severity: 2 Status: R [Resolved]
>     Version Found: 5.1(1)
>     Fixed-in Version: 5.1(2.206) 5.1(2.207)  5.2(1.200)

fixes have been incorporated for a number of different release trains for 
the pix.

Fixed-In Version now covers releases:
         5.1(2.206), 5.1(2.207), 5.2(1.200), 6.0(0.100), 5.2(3.210)


cheers,

lincoln.
NB. it has been posted that Raptor filewalls will also apparently fail to 
allow connections with ECN bits set.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
