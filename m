Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264213AbUIAIkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbUIAIkS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 04:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbUIAIiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 04:38:16 -0400
Received: from launch.server101.com ([216.218.196.178]:29912 "EHLO
	mail-pop3-1.server101.com") by vger.kernel.org with ESMTP
	id S264213AbUIAIho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 04:37:44 -0400
From: Tim Fairchild <tim@bcs4me.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: K3b and 2.6.9?
Date: Wed, 1 Sep 2004 18:37:33 +1000
User-Agent: KMail/1.6.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200408301047.06780.tim@bcs4me.com> <200408312037.00994.tim@bcs4me.com> <Pine.LNX.4.58.0408310959340.2295@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408310959340.2295@ppc970.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409011837.33073.tim@bcs4me.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 Sep 2004 03:05,  Linus Torvalds wrote:

> But exactly _because_ it makes so much sense to just change K3b to use
> O_RDWR in its open, I'm hoping that the K3b developers won't complain too
> much about the kernel changing to require more strict checking (obviously,
> I can understand that _users_ will complain - they only see the "it
> stopped working" part).

Thanks for the info. Yes, this is what I am seeing a lot on linux user 
lists... "Don't use kernel 2.6.8.1 - it is broken" and so forth. Which is why 
I was looking to gain some insight into the k3b problem so I feel I know a 
little about the subject when on the lists... And also like to do testing 
when I can to help... what little help it might be.

thanks,

tim
