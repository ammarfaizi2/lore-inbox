Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292348AbSBBS5w>; Sat, 2 Feb 2002 13:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292349AbSBBS5c>; Sat, 2 Feb 2002 13:57:32 -0500
Received: from are.twiddle.net ([64.81.246.98]:61081 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S292348AbSBBS52>;
	Sat, 2 Feb 2002 13:57:28 -0500
Date: Sat, 2 Feb 2002 10:57:14 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Anton Blanchard <anton@samba.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020202105714.A13803@are.twiddle.net>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Anton Blanchard <anton@samba.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E16WReX-0003gt-00@the-village.bc.nu> <Pine.LNX.4.33L.0202010903380.17106-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33L.0202010903380.17106-100000@imladris.surriel.com>; from riel@conectiva.com.br on Fri, Feb 01, 2002 at 09:04:45AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 09:04:45AM -0200, Rik van Riel wrote:
> As for not putting kernel objects everywhere, this comes
> naturally with HIGHMEM ;)

Not for 64-bit targets.


r~
