Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLLNkQ>; Tue, 12 Dec 2000 08:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129361AbQLLNkG>; Tue, 12 Dec 2000 08:40:06 -0500
Received: from www.wen-online.de ([212.223.88.39]:2065 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129226AbQLLNjz>;
	Tue, 12 Dec 2000 08:39:55 -0500
Date: Tue, 12 Dec 2000 14:09:14 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Bill Maidment <bill@maidment.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.0-test12 problem with init
In-Reply-To: <3A36045E.E40E31FF@maidment.com.au>
Message-ID: <Pine.Linu.4.10.10012121402090.1746-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2000, Bill Maidment wrote:

> Hi
> 
> I reported a problem with using 'init 1' with 2.4.0-test12-pre8 and was
> told it wasn't a kernel problem. I beg to differ, as it still happens
> with 2.4.0-test12 but not with 2.4.0-test12-pre7. What changed between
> pre7 and pre8 to make 'init 1' behave like 'init 5'? 'init 3' works
> correctly. The only change I've made is to build the new kernel.
> 
> The screen messages say it is going into single user mode, but it just
> doesn't.

Ding.  Plz send me ps lawx output at failure time via private mail.

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
