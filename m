Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131665AbQLVGq0>; Fri, 22 Dec 2000 01:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131696AbQLVGqO>; Fri, 22 Dec 2000 01:46:14 -0500
Received: from cambot.suite224.net ([209.176.64.2]:1030 "EHLO suite224.net")
	by vger.kernel.org with ESMTP id <S131665AbQLVGpz>;
	Fri, 22 Dec 2000 01:45:55 -0500
Message-ID: <001901c06bdf$1d6c74e0$3b42b0d1@pittscomp.com>
From: "Matthew D. Pitts" <mpitts@suite224.net>
To: "Robert B. Easter" <reaster@comptechnews.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <0012212320430F.02217@comptechnews>
Subject: Re: recommended gcc compiler version
Date: Fri, 22 Dec 2000 01:19:07 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Robert,
gcc 2.7.2.3 is the safest, but egcs 1.1.2 will work. any kernels built with
gcc 2.95.x work but can be buggy.

Matthew Pitts
mpitts@suite224.net

----- Original Message -----
From: Robert B. Easter <reaster@comptechnews.com>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, December 21, 2000 11:20 PM
Subject: recommended gcc compiler version


> This is a newbie question, but what are the recommended gcc compiler
versions
> for compiling,
>
> Linux 2.2.18?
>
> Linux 2.4.0?
>
>
> I'd rather use the recommended version than not and have difficult bugs.
>
> Thanks.  If there is a FAQ, kindy direct me to it, or, if this info isn't
in
> there specificly, perhaps a FAQ maintainer can add this stuff.
>
> --
> -------- Robert B. Easter  reaster@comptechnews.com ---------
> - CompTechNews Message Board   http://www.comptechnews.com/ -
> - CompTechServ Tech Services   http://www.comptechserv.com/ -
> ---------- http://www.comptechnews.com/~reaster/ ------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
