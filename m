Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291653AbSBNNql>; Thu, 14 Feb 2002 08:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291654AbSBNNqb>; Thu, 14 Feb 2002 08:46:31 -0500
Received: from gold.he.net ([216.218.149.2]:54026 "EHLO gold.he.net")
	by vger.kernel.org with ESMTP id <S291653AbSBNNqW>;
	Thu, 14 Feb 2002 08:46:22 -0500
Reply-To: <jss@pacbell.net>
From: "J.S.S." <jss@pacbell.net>
To: "Drew P. Vogel" <dvogel@intercarve.net>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: Unable to compile 2.5.4: "control reaches end of non-void functionm"
Date: Thu, 14 Feb 2002 05:49:09 -0800
Message-ID: <PGEMINDOPMDNMJINCKBNIEFICBAA.jss@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <Pine.LNX.4.33.0202131955210.17093-100000@northface.intercarve.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got it. Fixed it.
Still getting the video.o compile problem, but this hasn't been fixed yet
(although it's been discussed a bit, the outcome wasn't too clear).


-----Original Message-----
From: Drew P. Vogel [mailto:dvogel@intercarve.net]
Sent: Wednesday, February 13, 2002 4:56 PM
To: J.S.S.
Cc: Steve Kieu; linux-kernel
Subject: RE: Unable to compile 2.5.4: "control reaches end of non-void
functionm"


If it is in processor.h, search the archives. There was a patch for this
submitted to the list about a week ago.

--Drew Vogel

On Wed, 13 Feb 2002, J.S.S. wrote:

>I have this same problem on both my laptop and my testbox.  It happens
>everytime and I have yet to compile 2.5.4 successfully.  Although, I
suspect
>it's in my config file - I'm just using an old config file I used for my
>2.4.17 kernel which works just fine.
>
>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org
>[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Steve Kieu
>Sent: Tuesday, February 12, 2002 8:49 PM
>To: kernel
>Subject: Re: Unable to compile 2.5.4: "control reaches end of non-void
>functionm"
>
>
>
>Hi,
>
>It seems nobody having this problem? No one replies at
>least why, so I just want to add one more case of
>compiling error. Exactly the same message as yours.
>
>
>
>=====
>S.KIEU
>
>http://greetings.yahoo.com.au - Yahoo! Greetings
>- Send your Valentines love online.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>

--Drew Vogel

