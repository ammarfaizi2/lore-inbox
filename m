Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131330AbRA2XuM>; Mon, 29 Jan 2001 18:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131324AbRA2XuC>; Mon, 29 Jan 2001 18:50:02 -0500
Received: from c266492-a.lakwod1.co.home.com ([24.1.8.253]:27155 "EHLO
	benatar.snurgle.org") by vger.kernel.org with ESMTP
	id <S131249AbRA2Xtt>; Mon, 29 Jan 2001 18:49:49 -0500
Date: Mon, 29 Jan 2001 18:49:13 -0500 (EST)
From: William T Wilson <fluffy@snurgle.org>
To: alex@foogod.com
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Recommended swap for 2.4.x.
In-Reply-To: <20010129152335.H11411@draco.foogod.com>
Message-ID: <Pine.LNX.4.21.0101291826280.20955-100000@benatar.snurgle.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2001 alex@foogod.com wrote:

> This always struck me as the most stupid rule of thumb I'd ever heard
> of.  With this metric, systems which precisely need swap the most

It used to be basically meaningful, for systems that had to swap, instead
of page.  In those cases, in order to be assured of getting any use out of
the system, it had to be at least twice the amount of RAM needed.  Of
course, you could have twice as much swap as RAM, four times, eight
times... but twice was the usual amount.

It's pretty well useless now though, even on Solaris :}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
