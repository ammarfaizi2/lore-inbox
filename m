Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbUASN4a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 08:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbUASN4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 08:56:30 -0500
Received: from open.nlnetlabs.nl ([213.154.224.1]:18705 "EHLO
	open.nlnetlabs.nl") by vger.kernel.org with ESMTP id S264949AbUASN43
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 08:56:29 -0500
Date: Mon, 19 Jan 2004 14:56:19 +0100
From: Miek Gieben <miekg@atoom.net>
To: linux-kernel@vger.kernel.org
Cc: Nathan Poznick <kraken@drunkmonkey.org>
Subject: Re: aacraid and 2.6
Message-ID: <20040119135619.GA32393@atoom.net>
References: <20040119102647.GA23288@atoom.net> <20040119135228.GA7935@tao.wang-fu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040119135228.GA7935@tao.wang-fu.org>
User-Agent: Vim/Mutt/Linux
X-Home: www.miek.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[On 19 Jan, @14:52, Nathan wrote in "Re: aacraid and 2.6 ..."]
> Thus spake Miek Gieben:
> > Hello,
> > 
> > Last week I tried to get aacraid working under 2.6.1, which failed.  In
> > http://www.kernel.org/pub/linux/kernel/people/akpm/must-fix/must-fix-7.txt it
> > says:
> > 
> > 	o ideraid hasn't been ported to 2.5 at all yet.
> 
> However, aacraid is not ideraid.  I'm using the aacraid driver on a Dell
> PERC3 controller with no problems so far on 2.6.1-mm4.

hmmm, did you have any luck with 2.6.1?

In this case it's a SATA raid from Adaptec. So, if aacraid if not ide-raid, why
doesn't it work? 

puzzled,

grtz Miek
