Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132912AbQLNUiY>; Thu, 14 Dec 2000 15:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132972AbQLNUiO>; Thu, 14 Dec 2000 15:38:14 -0500
Received: from cs.columbia.edu ([128.59.16.20]:38394 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S132912AbQLNUiG>;
	Thu, 14 Dec 2000 15:38:06 -0500
Date: Thu, 14 Dec 2000 12:07:38 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: "David S. Miller" <davem@redhat.com>
cc: <mhaque@haque.net>, <linux-kernel@vger.kernel.org>
Subject: Re: ip_defrag is broken (was: Re: test12 lockups -- need feedback)
In-Reply-To: <200012141943.LAA08330@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0012141204210.27848-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2000, David S. Miller wrote:

> If you turn off netfilter, ip_conntrack, etc. does the OOPS still
> occur?

I'm afraid I won't be able to answer this question, since I'm leaving for
a 3-week vacation in about 50 minutes and I need my firewall functional
until then. :-) Maybe other people who have seen this problem can
experiment further.

If I get a few moments, I'll do a quick test before leaving and will let
you know. The chance of that happening is extremely slim, though.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
