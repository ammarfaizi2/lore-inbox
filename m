Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144642AbRA2Aen>; Sun, 28 Jan 2001 19:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144634AbRA2Aee>; Sun, 28 Jan 2001 19:34:34 -0500
Received: from femail3.rdc1.on.home.com ([24.2.9.90]:21177 "EHLO
	femail3.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S144642AbRA2AeV>; Sun, 28 Jan 2001 19:34:21 -0500
Message-ID: <3A74BA76.B24D032D@Home.net>
Date: Sun, 28 Jan 2001 19:33:58 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10a i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Andrew Morton <andrewm@uow.edu.au>, Shawn Starr <Shawn.Starr@Home.com>,
        Gregory Maxwell <greg@linuxpower.cx>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.x and 2.4.1-preX - Higher latency then 2.2.xkernels?
In-Reply-To: <203550000.980709430@tiny>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Andrew Morton
> <andrewm@uow.edu.au> wrote:

Ok, I've backed out of the low-latency patch but kept the timepegs patch in.
I've applied your reiserfs low-latency patch on a stock 2.4.1-pre11 kernel.

Let's see what happens :)

Shawn.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
