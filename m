Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136991AbRA1QGT>; Sun, 28 Jan 2001 11:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137077AbRA1QGJ>; Sun, 28 Jan 2001 11:06:09 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:41882 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S136991AbRA1QFu>; Sun, 28 Jan 2001 11:05:50 -0500
Message-ID: <3A74451F.DA29FD17@uow.edu.au>
Date: Mon, 29 Jan 2001 03:13:19 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
CC: linux-kernel@vger.kernel.org, lwn@lwn.net
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
In-Reply-To: <20010127151141.E8236@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo wrote:
> 
> Please send additions and corrections to me and I'll try
> to keep it updated.

Here - have about 300 bugs:

	http://www.uwsg.iu.edu/hypermail/linux/kernel/0005.3/0269.html

A lot of the timer deletion races are hard to fix because of
the deadlock problem.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
