Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317589AbSGOSoX>; Mon, 15 Jul 2002 14:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317592AbSGOSoV>; Mon, 15 Jul 2002 14:44:21 -0400
Received: from esteel10.client.dti.net ([209.73.14.10]:3967 "EHLO
	shookay.newview.com") by vger.kernel.org with ESMTP
	id <S317589AbSGOSoQ>; Mon, 15 Jul 2002 14:44:16 -0400
To: sam@vilain.net (Sam Vilain)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
References: <1026490866.5316.41.camel@thud> <E17U9x9-0001Dc-00@hofmann>
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
Date: 15 Jul 2002 14:47:04 -0400
In-Reply-To: <E17U9x9-0001Dc-00@hofmann>
Message-ID: <xltlm8c6d7b.fsf@shookay.newview.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sam@vilain.net (Sam Vilain) writes:
>   - there is a `dump' command (but it's useless, because it hangs when you
>     run it on mounted filesystems - come on, who REALLY unmounts their
>     filesystems for a nightly dump?  You need a 3 way mirror to do it
>     while guaranteeing filesystem availability...)

According to everybody, dump is deprecated (and it shouldn't work reliably
with 2.4, in two words: "forget it")...

-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
    It is exactly because a man cannot do a thing that he is a
                      proper judge of it.
                      -- Oscar Wilde
