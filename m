Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280104AbRKEBuC>; Sun, 4 Nov 2001 20:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280106AbRKEBtw>; Sun, 4 Nov 2001 20:49:52 -0500
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:34234 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S280104AbRKEBtq>; Sun, 4 Nov 2001 20:49:46 -0500
Message-ID: <3BE5F0B5.52274D07@kegel.com>
Date: Sun, 04 Nov 2001 17:51:49 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Luigi Genoni <kernel@Expansa.sns.it>
CC: Mike Galbraith <mikeg@wen-online.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stp@osdlab.org
Subject: Re: Regression testing of 2.4.x before release?
In-Reply-To: <Pine.LNX.4.33.0111041955290.30596-100000@Expansa.sns.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luigi Genoni wrote:
> Problem is:
> there is a lot of HW out there, and we should ALL do stress tests, to have
> a wide basis for HWs and test cases.  Basically it is very hard to agree
> about a set of stress tests, because we all have different needs, and our
> tests are based on our needs. That is a streght, because they tend to be
> real life tests.

Sure, no argument there.

> In my esperience, if some default set of tests comes out, then software
> tend to be optimized for this set. And that is badly wrong.

My post was motivated by two observations:

1. Alan Cox complains occasionally that Linus' trees are not well tested,
   and can't survive the torture tests that the ac tree goes through before
   release.  (e.g.
"2.4.8-ac12
        I'm trying to make sure I can keep this testable
        as 2.4.9 vanilla isnt being stable on my test sets "

2. The STP at OSDLab seems like a great resource that we might be able
to leverage to solve the problem Alan points out.

I'm not suggesting anyone do any less testing.  Just the opposite;
if we set things up properly with the STP, we might be able to run
many more tests before each final release.

- Dan
