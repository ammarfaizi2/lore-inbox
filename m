Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271708AbRIYV6R>; Tue, 25 Sep 2001 17:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271333AbRIYV57>; Tue, 25 Sep 2001 17:57:59 -0400
Received: from [195.223.140.107] ([195.223.140.107]:15344 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S271278AbRIYV5v>;
	Tue, 25 Sep 2001 17:57:51 -0400
Date: Tue, 25 Sep 2001 23:57:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: marcelo@conectiva.com.br, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
Message-ID: <20010925235754.F8350@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0109251446210.1495-100000@freak.distro.conectiva> <20010925.125758.94556009.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010925.125758.94556009.davem@redhat.com>; from davem@redhat.com on Tue, Sep 25, 2001 at 12:57:58PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 12:57:58PM -0700, David S. Miller wrote:
> or else deadlock is possible.  The spin_trylock is an optimization.

Indeed.

Andrea
