Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWIZUTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWIZUTn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWIZUTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:19:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9949 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932279AbWIZUTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:19:43 -0400
Date: Tue, 26 Sep 2006 13:19:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: x86/x86-64 merge for 2.6.19
In-Reply-To: <200609262202.28846.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0609261318240.3952@g5.osdl.org>
References: <200609261244.43863.ak@suse.de> <Pine.LNX.4.64.0609261241390.3952@g5.osdl.org>
 <200609262202.28846.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Sep 2006, Andi Kleen wrote:
> > 
> > I really don't want do http:// pulls - they are very inefficient, and I 
> > don't trust the end result because the http protocol isn't really good for 
> > verifying the end result (same goes for rsync:// to an even bigger 
> > degree). 
> 
> Sorry that was actually me typoing (my fingers are not used to git:// urls
> yet) I've sent you a new email with correct URL

I actually tried it with "git://" instead of "http://" bit maybe I typoed 
too.

Anyway, the new address was fine. Pulled, pushed out.

(Side note, I'm hoping we can sync up more easily now, and in smaller 
chunks ;)

		Linus
