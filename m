Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316965AbSEWQn7>; Thu, 23 May 2002 12:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316967AbSEWQn6>; Thu, 23 May 2002 12:43:58 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:54733 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316965AbSEWQn4>;
	Thu, 23 May 2002 12:43:56 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15597.7242.995639.291333@napali.hpl.hp.com>
Date: Thu, 23 May 2002 09:43:54 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, hugh@veritas.com, linux-kernel@vger.kernel.org,
        andrea@suse.de, torvalds@transmeta.com
Subject: Re: Q: PREFETCH_STRIDE/16
In-Reply-To: <20020523.092155.70675460.davem@redhat.com>
X-Mailer: VM 7.03 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 23 May 2002 09:21:55 -0700 (PDT), "David S. Miller" <davem@redhat.com> said:

  DaveM> All of these particular prefetches are amusing, with or
  DaveM> without your fix, considering there are other more powerful
  DaveM> ways to optimize this stuff. :-)

What do you have in mind?

	--david
