Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268511AbRIDVnt>; Tue, 4 Sep 2001 17:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269318AbRIDVnj>; Tue, 4 Sep 2001 17:43:39 -0400
Received: from hera.cwi.nl ([192.16.191.8]:3998 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S268511AbRIDVn1>;
	Tue, 4 Sep 2001 17:43:27 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 4 Sep 2001 21:43:43 GMT
Message-Id: <200109042143.VAA57901@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, bcrl@redhat.com
Subject: Re: [resend PATCH] reserve BLKGETSIZE64 ioctl
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From bcrl@redhat.com Tue Sep  4 22:54:05 2001

    On Tue, 4 Sep 2001 Andries.Brouwer@cwi.nl wrote:

    > Then I am happy (as long as you don't take a reserved number).

    So the patch below is okay?

Roughly speaking, yes.

(But why do you insist on using 110?
I wrote "A jump here: 108-111 have been used" because that is
what I recall: three groups using 108-109 and one shifting to
110-111. I have no details, so may misremember, but still..)


Andries
