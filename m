Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284579AbRLETMu>; Wed, 5 Dec 2001 14:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284594AbRLETMj>; Wed, 5 Dec 2001 14:12:39 -0500
Received: from alageremail1.agere.com ([192.19.192.106]:19659 "EHLO
	alageremail1.agere.com") by vger.kernel.org with ESMTP
	id <S284589AbRLETMM>; Wed, 5 Dec 2001 14:12:12 -0500
From: "Michael Smith" <smithmg@agere.com>
To: <root@chaos.analogic.com>
Cc: "'John Levon'" <movement@marcelothewonderpenguin.com>,
        <linux-kernel@vger.kernel.org>, <kernelnewbies@nl.linux.org>
Subject: RE: Unresolved symbol memset
Date: Wed, 5 Dec 2001 14:12:02 -0500
Organization: Agere Systems
Message-ID: <00ab01c17dc0$b91e2d40$4d129c87@agere.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <Pine.LNX.3.95.1011205140644.8292A-100000@chaos.analogic.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That 'O' was a miss type, it is '0' in the makefile.  Sorry

-----Original Message-----
From: Richard B. Johnson [mailto:root@chaos.analogic.com] 
Sent: Wednesday, December 05, 2001 2:09 PM
To: Michael Smith
Cc: 'John Levon'; linux-kernel@vger.kernel.org;
kernelnewbies@nl.linux.org
Subject: RE: Unresolved symbol memset

On Wed, 5 Dec 2001, Michael Smith wrote:

> I have optimization turned.  Using -02 in the makefile.
>                                     ^___________ < Need more coffee >

It's -O2, not -02 


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.

