Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310769AbSERJ1Q>; Sat, 18 May 2002 05:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310666AbSERJ1P>; Sat, 18 May 2002 05:27:15 -0400
Received: from pop.gmx.net ([213.165.64.20]:30706 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S293457AbSERJ1P>;
	Sat, 18 May 2002 05:27:15 -0400
Date: Sat, 18 May 2002 11:25:11 +0100
From: "Mike Galbraith" <EFAULT@gmx.de>
To: "Wayne.Brown@altec.com" <Wayne.Brown@altec.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
X-mailer: Foxmail 4.1 [eg]
Mime-Version: 1.0
Content-Type: text/plain;
      charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <20020518092715Z293457-22651+36580@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Someone said here on the list a few months ago that "make bzlilo" was replaced
>by "make install" and that it was necessary to configure the "install" option's
>behavior.

Someone said?  Your opinion on this subject just lost all of it's value.

	-Mike


>David Lang <david.lang@digitalinsight.com> on 05/18/2002 12:23:10 AM
>
>To:   Wayne Brown/Corporate/Altec@Altec
>cc:   linux-kernel@vger.kernel.org
>
>Subject:  Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
>
>
>
>Wayne, the only change (other then better, faster functions) is the
>elimination of steps.
>
>if it will satisfy you you can continue to do a make mproper and make dep
>and just ignore the 'no target found' messages.
>
>David Lang
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


