Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272516AbRIRQkH>; Tue, 18 Sep 2001 12:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272531AbRIRQj5>; Tue, 18 Sep 2001 12:39:57 -0400
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:57988 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S272516AbRIRQjr>;
	Tue, 18 Sep 2001 12:39:47 -0400
Message-ID: <3BA778E5.B1741B42@pobox.com>
Date: Tue, 18 Sep 2001 09:40:05 -0700
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-pre11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Kegel <dank@kegel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ext3/ext2 compatibility; time for ext3 in mainline kernel?
In-Reply-To: <3BA76A01.C2B5E701@kegel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First beta or second?

The first was full of weird bugs like that -

The second beta has been running solidly here.

cu

jjs

Dan Kegel wrote:

> I installed Red Hat 7.2beta, and chose its nifty ext3 option when
> setting up my partitions.  But now when I boot into vanilla 2.4.9,
> some files are mysteriously missing, notably /usr/bin/id and
> /usr/lib/libreadline.so.3, judging from the error messages that spew
> when I try to do anything.
>
> I guess either a) there's a bug, or b) ext3 isn't so compatible with ext2
> that you can just boot into an ext2-only kernel and expect things to work.
>
> If b) is true, I'd really really like vanilla 2.4.11 or so to support ext3.
> Isn't it about time?
>
> - Dan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

