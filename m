Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318067AbSHSErz>; Mon, 19 Aug 2002 00:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318072AbSHSErz>; Mon, 19 Aug 2002 00:47:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1245 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318067AbSHSEry>;
	Mon, 19 Aug 2002 00:47:54 -0400
Date: Sun, 18 Aug 2002 21:37:19 -0700 (PDT)
Message-Id: <20020818.213719.117777405.davem@redhat.com>
To: zdzichu@irc.pl
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and full ipv6 - will it happen?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020819043941.GA31158@irc.pl>
References: <20020819043941.GA31158@irc.pl>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Tomasz Torcz, BG" <zdzichu@irc.pl>
   Date: Mon, 19 Aug 2002 06:39:41 +0200
   
   Linux still has superior networking, but protocol of the future is IPv6.

That is your opinion.  This is what people have been saying since some
6 or 7 years ago, and ipv6 has not moved much further out of
experimental state since then.

   Full IPv6 stack is beeing mantained by USAGI project.

Yes, and based upon previous attempts to get them to merge their work
into the mainline, we believe at this point that they actually enjoy
being a totally seperate project and not merging completely is a
feature for them.

USAGI may only accept that comment, and the only way they may
disprove it is to merge their code to us as we have continually
requested them to do so.

In my opinion, USAGI has been given more than adequate opportunities
to merge their entire work into the mainline.  Alexey Kuznetsov has
asked them repeatedly over the years to merge with him, yet they
always fail to do so completely.  Occaisionally one or two trivially
bug fixes they are able to merge, but otherwise their efforts always
fall short.

They claim they wish to merge so badly, yet act in opposite manner.
It is almost disgraceful and I am so tired of this continual public
propaganda that tries to make it look as if Alexey and myself are to
blame for this.
