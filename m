Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132405AbQLQWOo>; Sun, 17 Dec 2000 17:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132430AbQLQWOf>; Sun, 17 Dec 2000 17:14:35 -0500
Received: from [129.142.25.50] ([129.142.25.50]:17551 "HELO mail.storner.dk")
	by vger.kernel.org with SMTP id <S132405AbQLQWOQ>;
	Sun, 17 Dec 2000 17:14:16 -0500
To: linux-kernel@vger.kernel.org
Path: news.storner.dk!not-for-mail
From: henrik@storner.dk (Henrik Størner)
Newsgroups: linux.kernel
Subject: Re: test12: innd bug came back?
Date: 17 Dec 2000 22:43:49 +0100
Organization: Linux Users Inc.
Message-ID: <91jc2l$7tn$1@osiris.storner.dk>
In-Reply-To: <3A3D06D3.93041108@freeler.nl> <Pine.GSO.4.21.0012171626000.20573-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Newsreader: NN version 6.5.6 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In <Pine.GSO.4.21.0012171626000.20573-100000@weyl.math.psu.edu> Alexander Viro <viro@math.psu.edu> writes:

>On Sun, 17 Dec 2000, Jorg de Jong wrote:

>> > >On 13 Dec 2000, Henrik [ISO-8859-1] Størner wrote:
>> > >
>> > >> Just to add a "me too" on this. I didn't report when I saw it last week

>> I'd like to second that. ME TOO !
>> Since I switched to 2.4.0.test12 I again have the innd bug.
>> ( well at least the same symptoms !)

>Guys, what blocksize are you using?

I am using Reiserfs, and I hear it has some problems with the changes
introduced in pre12. So I will report back once the Reiserfs guys get 
this settled.
-- 
Henrik Storner      | "Crackers thrive on code secrecy. Cockcroaches breed 
<henrik@storner.dk> |  in the dark. It's time to let the sunlight in."
                    |  
                    |          Eric S. Raymond, re. the Frontpage backdoor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
