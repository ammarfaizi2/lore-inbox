Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290723AbSAYQwN>; Fri, 25 Jan 2002 11:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290725AbSAYQwA>; Fri, 25 Jan 2002 11:52:00 -0500
Received: from cs182083.pp.htv.fi ([213.243.182.83]:6784 "EHLO
	cs182083.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S290723AbSAYQvi>; Fri, 25 Jan 2002 11:51:38 -0500
Message-ID: <3C518D25.F8062F2B@welho.com>
Date: Fri, 25 Jan 2002 18:51:49 +0200
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17o1-ll-elv i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: White Paper on the Linux kernel VM?
In-Reply-To: <Pine.LNX.4.33L.0201241312450.32617-100000@imladris.surriel.com> <3C50827F.F425DDF2@welho.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Writing about not writing docs wastes everybody's time.

For the record, I would love to see some proper documentation on the
current VM. While the code is indeed the ultimate reference, it does not
yield readily to peer review.

That said, I don't think much of the waterfall model. It tends to kill
the enthusiasm and slow projects down to a crawl. The thing is to write
the code, hone it until you're happy with it, and then document it. If
the code isn't ready to document, it's not ready for peer review. Prior
to that degree of readiness, too many brains plucking at the code just
slows things down. On the other hand, if you leave out the documentation
altogether you end up with developers arguing about who can't read whose
code, instead of doing something useful.

I seemed to touch the hearts of a surprising number of people with my
thoughtless little remark. No permanent heart ache, I hope. :)

	MikaL
