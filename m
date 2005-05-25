Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVEYUqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVEYUqz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 16:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVEYUqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 16:46:54 -0400
Received: from fire.osdl.org ([65.172.181.4]:18650 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261555AbVEYUqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 16:46:51 -0400
Date: Wed, 25 May 2005 13:48:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, Netdev <netdev@oss.sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patches try2] 2.6.x net driver updates
In-Reply-To: <4294BD9C.2050105@pobox.com>
Message-ID: <Pine.LNX.4.58.0505251200040.2307@ppc970.osdl.org>
References: <4294BD9C.2050105@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 25 May 2005, Jeff Garzik wrote:
>
> Does this work better?

Looks good.

If this was automated, are your changes to git-pull-script generic enough 
to be useful for others, or did you do a totally specialized one for just 
the "lots of heads in the same directory" case?

		Linus
