Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284662AbRLPPiW>; Sun, 16 Dec 2001 10:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284659AbRLPPiN>; Sun, 16 Dec 2001 10:38:13 -0500
Received: from dsl-65-186-161-49.telocity.com ([65.186.161.49]:49165 "EHLO
	nic.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S284662AbRLPPh5>; Sun, 16 Dec 2001 10:37:57 -0500
Message-Id: <4.3.2.7.2.20011216103506.00d94b90@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sun, 16 Dec 2001 10:37:53 -0500
To: lkml <linux-kernel@vger.kernel.org>
From: David Relson <relson@osagesoftware.com>
Subject: Re: Linux 2.4.17-rc1
Cc: Dave Jones <davej@suse.de>, Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.33.0112161523360.876-100000@Appserv.suse.de>
In-Reply-To: <4.3.2.7.2.20011216091040.00d7c180@mail.osagesoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik & Dave,

(as I sheepishly wipes egg off my face), guess it's time for "rc2", not 
"final".

I guess I skipped too many lkml messages before posting mine.  'Sorry about 
that.

David

At 09:26 AM 12/16/01, Dave Jones wrote:
>On Sun, 16 Dec 2001, David Relson wrote:
>
> > IMHO, 2.4.17-rc1 seems to be ready to be promoted to 2.4.17. It's passed a
> > suitable "release candidate" test - available for a couple of days and
> > nobody has found any major problems.
>
>Except for loop deadlock, sysvfs oops, and a glut of __devexit
>non-compiles. Whilst the sysvfs oops shouldn't affect many, loop
>is used by a lot of people, and the __devexit patches would save
>us another month of debian sid users who don't bother to read archives.
>
>regards,
>Dave.
>
>--
>| Dave Jones.        http://www.codemonkey.org.uk
>| SuSE Labs
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

