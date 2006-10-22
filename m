Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbWJVU6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWJVU6Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 16:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWJVU6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 16:58:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55703 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751505AbWJVU6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 16:58:23 -0400
Date: Sun, 22 Oct 2006 13:58:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: art@usfltd.com
cc: linux-kernel@vger.kernel.org, rjw@sisk.pl
Subject: Re: 2.6.19-rc2-git7 shutdown problem
In-Reply-To: <20061022145210.n736g78k42e8ggkg@69.222.0.225>
Message-ID: <Pine.LNX.4.64.0610221356440.3962@g5.osdl.org>
References: <20061022145210.n736g78k42e8ggkg@69.222.0.225>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 22 Oct 2006, art@usfltd.com wrote:
>
> 2.6.19-rc2-git7 shutdown problem
> 
> below are last shutdown messages - system is hunging forever !
> hda was mounted, hdb not
> any clue ?

Noting springs to mind immediately.

Can you narrow this down more specifically? Did you test 2.6.19-rc2-git6, 
and that was fine? Or did you just happen to test -git7, and the previous 
kernel you did this on was some much older one?

			Linus
