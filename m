Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271818AbRIQQcm>; Mon, 17 Sep 2001 12:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271809AbRIQQcc>; Mon, 17 Sep 2001 12:32:32 -0400
Received: from fw2.aub.dk ([195.24.1.195]:34804 "EHLO Princess")
	by vger.kernel.org with ESMTP id <S271832AbRIQQc1>;
	Mon, 17 Sep 2001 12:32:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Allan Sandfeld <linux@sneulv.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bzImage target for PPC
Date: Mon, 17 Sep 2001 18:32:25 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <E15ivIz-00087v-00@wagner>
In-Reply-To: <E15ivIz-00087v-00@wagner>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15j1Jr-0002ci-00@Princess>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 September 2001 12:07, Rusty Russell wrote:

> Actually, Paul suggested it.  As for bzlilo, that's even a problem on
> non-lilo Intel (and should be subsumed by make install).  Of course,
> make install should be moved to the top level Makefile, but that's
> another battle.
Welll.... Shouldnt we fight it then?
What is holding us back from deciding on a limited number of supported and 
implemented make targets and making these fast(e.g. moving install to top 
level)? This would then become a part of kbuild2.5

"Let's party like it's 2.4.99"

>
> Cheers,
> Rusty.

Cheers!
