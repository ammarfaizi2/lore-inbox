Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129983AbRAOCfw>; Sun, 14 Jan 2001 21:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130290AbRAOCfm>; Sun, 14 Jan 2001 21:35:42 -0500
Received: from [204.244.205.25] ([204.244.205.25]:50758 "HELO post.gateone.com")
	by vger.kernel.org with SMTP id <S129983AbRAOCfd>;
	Sun, 14 Jan 2001 21:35:33 -0500
From: Michael Peddemors <michael@linuxmagic.com>
Organization: Wizard Internet Services
To: Gerhard Mack <gmack@innerfire.net>
Subject: Re: Is sendfile all that sexy?
Date: Sun, 14 Jan 2001 19:43:34 -0800
X-Mailer: KMail [version 1.1.95.0]
Content-Type: text/plain
Cc: Ingo Molnar <mingo@elte.hu>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10101141436010.4613-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10101141436010.4613-100000@penguin.transmeta.com>
MIME-Version: 1.0
Message-Id: <01011419433404.00214@mistress>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The two things I change everytime are sendmail->qmail and wuftpd->proftpd

But remember, security bugs are caught because more people use one vs the 
other..  Bugs in Proftpd weren't caught until more people started changing 
from wu-ftpd...

Often, all it means when one product has more bugs than another, is that more 
people tried to find bugs in one than another...

(Yes, a plug to get everyone to test 2.4 here)

On Sun, 14 Jan 2001, Linus Torvalds wrote:
> On Sun, 14 Jan 2001, Gerhard Mack wrote:
> > PS I wish someone would explain to me why distros insist on using WU
> > instead given it's horrid security record.
>
> Of course, you may be right on wuftpd. It obviously wasn't designed with
> security in mind, other alternatives may be better.
>
> 		Linus

-- 
--------------------------------------------------------
Michael Peddemors - Senior Consultant
Unix Administration - WebSite Hosting
Network Services - Programming
Wizard Internet Services http://www.wizard.ca
Linux Support Specialist - http://www.linuxmagic.com
--------------------------------------------------------
(604) 589-0037 Beautiful British Columbia, Canada
--------------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
