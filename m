Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276738AbRJBWTk>; Tue, 2 Oct 2001 18:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276745AbRJBWTT>; Tue, 2 Oct 2001 18:19:19 -0400
Received: from maila.telia.com ([194.22.194.231]:23498 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S276738AbRJBWTK>;
	Tue, 2 Oct 2001 18:19:10 -0400
Message-ID: <3BBA3D74.3452996E@canit.se>
Date: Wed, 03 Oct 2001 00:19:32 +0200
From: Kenneth Johansson <ken@canit.se>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: System reset on Kernel 2.4.10
In-Reply-To: <527872464EC@vcnet.vc.cvut.cz> <20011002234115.A1891@vana.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:

>
> I was not able to find where problem could be with unpatched
> kernel, but arguments passed to do_brk(), set into mm->start_brk,
> {start,end}_code and so on looks very suspicious... But as on my
> system it does not crash neither with nor without patch below, I
> leave answer on someone else.

I no longer get the restart but then I also made more than this change to the kernel and tested
with the new vmlinux image.

