Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbUJaAs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbUJaAs6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 20:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUJaAs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 20:48:58 -0400
Received: from cantor.suse.de ([195.135.220.2]:47286 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261452AbUJaAsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 20:48:50 -0400
Date: Sun, 31 Oct 2004 02:48:48 +0200
From: Andi Kleen <ak@suse.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Tim Hockin <thockin@hockin.org>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: code bloat [was Re: Semaphore assembly-code bug]
Message-ID: <20041031004848.GC19396@wotan.suse.de>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel> <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua> <20041030222720.GA22753@hockin.org> <200410310213.37712.vda@port.imtp.ilyichevsk.odessa.ua> <1099178405.1441.7.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099178405.1441.7.camel@krustophenia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 07:20:04PM -0400, Lee Revell wrote:
> On Sun, 2004-10-31 at 02:13 +0300, Denis Vlasenko wrote:
> > It's sort of frightening that someone will need to
> > rewrite Xlib or, say, OpenOffice :(
> 
> I think very few application developers understand the point Linus made
> - that bigger code IS slower code due to cache misses.  If this were
> widely understood we would be in pretty good shape.

It's true in some cases, but not true in others. Don't make it your
gospel. 

-Andi
