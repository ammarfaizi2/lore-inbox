Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272197AbRIRPgd>; Tue, 18 Sep 2001 11:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272233AbRIRPgX>; Tue, 18 Sep 2001 11:36:23 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:11761 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S272197AbRIRPgK>; Tue, 18 Sep 2001 11:36:10 -0400
Message-ID: <3BA76A01.C2B5E701@kegel.com>
Date: Tue, 18 Sep 2001 08:36:33 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: ext3/ext2 compatibility; time for ext3 in mainline kernel?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I installed Red Hat 7.2beta, and chose its nifty ext3 option when
setting up my partitions.  But now when I boot into vanilla 2.4.9,
some files are mysteriously missing, notably /usr/bin/id and
/usr/lib/libreadline.so.3, judging from the error messages that spew
when I try to do anything.

I guess either a) there's a bug, or b) ext3 isn't so compatible with ext2
that you can just boot into an ext2-only kernel and expect things to work.

If b) is true, I'd really really like vanilla 2.4.11 or so to support ext3.
Isn't it about time?

- Dan
