Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317471AbSHLIAJ>; Mon, 12 Aug 2002 04:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317473AbSHLIAJ>; Mon, 12 Aug 2002 04:00:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33434 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317471AbSHLIAI>;
	Mon, 12 Aug 2002 04:00:08 -0400
Date: Mon, 12 Aug 2002 00:50:22 -0700 (PDT)
Message-Id: <20020812.005022.69048367.davem@redhat.com>
To: davids@webmaster.com
Cc: jroland@roland.net, Hell.Surfers@cwctv.net, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: The spam problem.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020812073558.AAA17330@shell.webmaster.com@whenever>
References: <002701c241bf$54e64010$2102a8c0@gespl2k1>
	<20020812073558.AAA17330@shell.webmaster.com@whenever>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nobody has mentioned the fact that spammers can forge the
From: field just like anyone else can.

If you enforce that the first sender at the Received: headers
have to match the From: or some rule like that, then I could
not post to these lists for example.

This is why enforcing that subscribers only can post to the lists is
totally unacceptablt.  It doesn't stop spam, it's merely a deterrant
and it serves mostly to piss off legitimate users of these lists.
