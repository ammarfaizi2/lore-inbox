Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWGGFNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWGGFNI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 01:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWGGFNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 01:13:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54186 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751180AbWGGFNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 01:13:06 -0400
Date: Thu, 6 Jul 2006 22:12:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Michael Kerrisk <michael.kerrisk@gmx.net>
cc: linux-kernel@vger.kernel.org, tytso@mit.edu, eggert@cs.ucla.edu,
       roland@redhat.com, rlove@rlove.org, mtk-lkml@gmx.net,
       mtk-manpages@gmx.net, drepper@redhat.com, manfred@colorfullife.com
Subject: Re: Re: Strange Linux behaviour with blocking syscalls and stop
 signals+SIGCONT
In-Reply-To: <Pine.LNX.4.64.0607062205470.3869@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0607062212100.3869@g5.osdl.org>
References: <44A92DC8.9000401@gmx.net> <44AABB31.8060605@colorfullife.com>
 <20060706092328.320300@gmx.net> <44AD599D.70803@colorfullife.com>
 <44AD5CB6.7000607@redhat.com> <44AD5E5C.6070703@colorfullife.com>
 <Pine.LNX.4.64.0607061217320.3869@g5.osdl.org> <20060707045733.186790@gmx.net>
 <Pine.LNX.4.64.0607062205470.3869@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Jul 2006, Linus Torvalds wrote:
> 
> I want to say that the failing app was "oneko" (damn, I should try to find 
> if it still exists - brings back memories of an earlier time)

Ahh. "yum install oneko" and there it is. 

I feel calmer already.

		Linus
