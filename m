Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290141AbSAKW0F>; Fri, 11 Jan 2002 17:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290145AbSAKWZz>; Fri, 11 Jan 2002 17:25:55 -0500
Received: from are.twiddle.net ([64.81.246.98]:47238 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S290141AbSAKWZu>;
	Fri, 11 Jan 2002 17:25:50 -0500
Date: Fri, 11 Jan 2002 14:25:45 -0800
From: Richard Henderson <rth@twiddle.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Fix fs/fat/inode.c when compiled with gcc-3.0.x
Message-ID: <20020111142545.B9873@twiddle.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <3C3E6163.2E4ECB03@mandrakesoft.com> <Pine.LNX.4.33.0201102027500.3540-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201102027500.3540-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Jan 10, 2002 at 08:29:56PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 08:29:56PM -0800, Linus Torvalds wrote:
> It is, but there was a bug in the PPC machine description in 3.0.x
> (x=0,1), or something. It's supposedly fixed in later gcc's.

Apparently I only committed the patch to mainline.  Oops.


r~
