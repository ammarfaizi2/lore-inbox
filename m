Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbVKVD4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVKVD4t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 22:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbVKVD4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 22:56:49 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:40461 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S932075AbVKVD4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 22:56:48 -0500
Date: Tue, 22 Nov 2005 11:57:16 -0500 (EST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: ocroquette@free.fr
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Automount ghost option
In-Reply-To: <43822E56.7090909@ocroquette.free.fr>
Message-ID: <Pine.LNX.4.58.0511221133470.24323@wombat.indigo.net.au>
References: <5ainN-x5-11@gated-at.bofh.it> <5arK7-5L9-5@gated-at.bofh.it>
 <43822E56.7090909@ocroquette.free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-5.899,
	required 5, autolearn=not spam, ALL_TRUSTED -3.30, BAYES_00 -2.60)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005, Olivier Croquette wrote:

> Ian Kent wrote:
> >>Nevertheless, on some recent distributions I have tested on, this option is
> >>not available.
> > 
> > For example?
> 
> I tried on SuSE 9.2 and 9.3 and it didn't work.
> 
> After a short investigation based on your info, this is what came out:
> 
> On SuSE 9.2, it's because it is still using a 3.x autofs.
> On SuSE 9.3, it's because it doesn't work with the --ghost option in the 
> auto.x NIS map file. It works only if I put the option in the 
> /etc/sysconfig/autofs global settings.

That's a bit of a shame.

There's really not much I can do to help if I'm not asked.

Ian

