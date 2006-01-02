Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWABHaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWABHaj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 02:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWABHai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 02:30:38 -0500
Received: from main.gmane.org ([80.91.229.2]:50571 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932332AbWABHah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 02:30:37 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: Howto set kernel makefile to use particular gcc
Date: Mon, 02 Jan 2006 16:21:53 +0900
Message-ID: <dpakah$tip$2@sea.gmane.org>
References: <3AEC1E10243A314391FE9C01CD65429B223AF3@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051023)
X-Accept-Language: en-us, en
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B223AF3@mail.esn.co.in>
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not top-post!
http://en.wikipedia.org/wiki/Toppost

Mukund JB. wrote:
> Jasper,
> 
> But I was doing it all that I was doing with 2.4 i.e. the follwoing steps to build the kernel.
> I also found these steps are followed in the 2.6.x kernel build howto's too.
> 
> Do you mean, to rebuild the 2.6.x kernel,
> 
> 	make CC=<path of gcc> would be enough?
> 
Yes that will do to compile any 2.6.x kernel.

> I am just thinking whether I am doing something redundent.
Just a bit, usually not a problem (but may be wrong).

Kalin.
-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

