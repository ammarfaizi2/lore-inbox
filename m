Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUCFLjd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 06:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbUCFLjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 06:39:33 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:32448 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S261654AbUCFLjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 06:39:32 -0500
Subject: Re: nicksched v30
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Nick Piggin <piggin@cyberone.com.au>, akpm@osdl.org, mfedyk@matchmail.com
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <4049485B.3070104@cyberone.com.au>
References: <4048204E.8000807@cyberone.com.au>
	 <1078488995.13256.1.camel@midux>  <4049485B.3070104@cyberone.com.au>
Content-Type: text/plain
Message-Id: <1078573144.1850.7.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Mar 2004 13:39:04 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-06 at 05:41, Nick Piggin wrote:
> Unfortunately not. The scheduler in -mm is different enough
> that porting isn't straightfoward.
> 
> What does mm break for you?
I don't know about the current, but one or two versions back when I
tested the last time it printed something about unknown key for the
whole dmesg and couldn't find /dev/hd{b,c}. After investigations the
hard-drives had changed place for some reason (Not swapped place, but
they were in a weird location, can't recall which).

I'll try the new one when I have time to boot this one.
 
        Markus

