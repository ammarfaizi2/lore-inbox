Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268092AbUIAEZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268092AbUIAEZq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 00:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268083AbUIAEZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 00:25:46 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:39436 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S268092AbUIAEZb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 00:25:31 -0400
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cleanup ptrace stops and remove notify_parent
References: <200409010011.i810BW5S001885@magilla.sf.frob.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 01 Sep 2004 13:25:16 +0900
In-Reply-To: <200409010011.i810BW5S001885@magilla.sf.frob.com>
Message-ID: <87llfubopf.fsf@ibmpc.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> writes:

> > Should we also clean up and improve those with user-visible change?
> > Those should be thought as separate issue?
> 
> The first answer to give is to the second question: yes, this is a
> separate subject from the implementation changes we are discussing right
> now.  I don't really want to get into discussing a different interface at
> the moment, because I have more than enough to do this week already.

No. You are missing my point. This is user-visible change, not
implementation only.

Is it sane way to do user-visible change for preparation?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
