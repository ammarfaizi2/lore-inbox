Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbTIAWSY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 18:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263312AbTIAWSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 18:18:24 -0400
Received: from main.gmane.org ([80.91.224.249]:3275 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263309AbTIAWSX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 18:18:23 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Stephane LOEUILLET <news@leroutier.net>
Subject: Re: 500 typos (94 uniques) fixed in 2.4.22 + link to diff included
Date: Tue, 02 Sep 2003 00:19:20 +0200
Message-ID: <pan.2003.09.01.22.19.20.280682@leroutier.net>
References: <pan.2003.09.01.18.15.22.368626@leroutier.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Pan/0.14.0 (I'm Being Nibbled to Death by Cats!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The script : http://www.leroutier.net/kernel-typo-diffmaker.pl.txt
> The typo list : http://www.leroutier.net/typos.base

latest version of typos.base contains 94 unique typos
(around 560, counting repetitions)

Generated diff available, against kernel 2.4.22 final : 
http://www.leroutier.net/typos.diff.bz2

most part of changes are in comments, or in documentation but there are
some in code (incomming => incoming in bluetooth,X25 and interupt->
interrupt in ppc64,ipmi)

this diff contains 2 manually edited changes :
1) addresses => adresses : (in fact, revert to 2.4.22 code) : it is a comment
in french

2) errorr => error : i'll have to refine my script to deal with that one

That's all for now.

If you want one for 2.6, do it yourself using my script because i'm on a slow
link here (56Kb/s) and i don't have a recent dev-source actually here.

++

Stephane LOEUILLET


