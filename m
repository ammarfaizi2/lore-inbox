Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTDZRxf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 13:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbTDZRxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 13:53:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27147 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262694AbTDZRxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 13:53:34 -0400
Date: Sat, 26 Apr 2003 11:06:33 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Shachar Shemesh <lkml@shemesh.biz>
cc: Zack Brown <zbrown@tumblerings.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ChangeLog suggestion
In-Reply-To: <3EAAC588.9010806@shemesh.biz>
Message-ID: <Pine.LNX.4.44.0304261103540.2276-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 26 Apr 2003, Shachar Shemesh wrote:
>
> Note that the "author" info is only semi readable from CVS. It contains 
> just the user part of the email address (in my case - "lkml" for spam 
> reasons - hardly a unique identifier). I'm told that under BK it has the 
> full email, so I'm not sure where that stands there.

People have indeed asked me to do that even for the BK tree - to avoid 
spammers picking up the address. I don't want to do it.

Personally, I want to have some address that I can reach the author at,
and if that means that spammers can pick it up too (open source means that
everybody has the same stuff _I_ have) I guess people who want to talk to
me need to live with spam filters or send patches to me from special 
accounts.

But both the short-format changelog (the ones posted to linux-kernel) and 
the CVS tree do hide the addresses somewhat.

			Linus

