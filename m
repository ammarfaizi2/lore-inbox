Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131369AbRABT0v>; Tue, 2 Jan 2001 14:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131554AbRABT0l>; Tue, 2 Jan 2001 14:26:41 -0500
Received: from raven.toyota.com ([63.87.74.200]:61200 "EHLO raven.toyota.com")
	by vger.kernel.org with ESMTP id <S131369AbRABT0a>;
	Tue, 2 Jan 2001 14:26:30 -0500
Message-ID: <3A522432.64FF7B7E@toyota.com>
Date: Tue, 02 Jan 2001 10:55:46 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Compile errors: RCPCI, LANE, and others
In-Reply-To: <E14DVBT-0002YO-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> Bzzt, wrong. Red Hat 7 compiles the 2.4 tree beautifully with gcc 2.96 as well.
> Please grow up.

Yes indeed - on my quad CPU Red Hat 7 server, I accidentally
forgot to say CC=kgcc during the last kernel build, and ended
up with a gcc-2.96 built kernel. I decided to let it run and see
what happens - It's been up and running -test12 for about 20
days now, solid as a rock.

My home system, an AMD k6, likewise is very very happy
running 2.4.0-prerelase compiled with gcc 2.96

jjs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
