Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265919AbUBGWDx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 17:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265920AbUBGWDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 17:03:53 -0500
Received: from mta8.srv.hcvlny.cv.net ([167.206.5.75]:36507 "EHLO
	mta8.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S265919AbUBGWDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 17:03:51 -0500
Date: Sat, 07 Feb 2004 17:05:10 -0500
From: Robert F Merrill <griever@t2n.org>
Subject: Re: 2.6.2-mm1 won't compile (been doing this since 2.6.1-mm2 or so)
In-reply-to: <20040207213646.GE7388@fs.tum.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <40256116.9050206@t2n.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107
 Debian/1.5-3
References: <402558C0.5010100@t2n.org> <20040207213646.GE7388@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>It seems when you did "make oldconfig" you said "no" to all cpu options.
>
>You should select the cpu type(s) you want to run your kernel on.
>
>Run "make menuconfig" and select the appropriate cpu types in
>  Processor type and features
>    Processor support
>
>cu
>Adrian
>
>  
>
Hm... how did that happen?


