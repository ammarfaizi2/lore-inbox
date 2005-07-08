Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262699AbVGHQS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbVGHQS6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 12:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbVGHQSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 12:18:47 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:32413 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262698AbVGHQS0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 12:18:26 -0400
Subject: Re: share/private/slave a subtree
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ram <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>, mike@waychison.com, bfields@fieldses.org,
       Miklos Szeredi <miklos@szeredi.hu>
In-Reply-To: <Pine.LNX.4.61.0507081527040.3743@scrub.home>
References: <1120816072.30164.10.camel@localhost>
	 <1120816229.30164.13.camel@localhost> <1120817463.30164.43.camel@localhost>
	 <84144f0205070804171d7c9726@mail.gmail.com>
	 <Pine.LNX.4.61.0507081412280.3743@scrub.home>
	 <courier.42CE70EE.000029AA@courier.cs.helsinki.fi>
	 <Pine.LNX.4.61.0507081441440.3728@scrub.home>
	 <courier.42CE788F.00003AE7@courier.cs.helsinki.fi>
	 <Pine.LNX.4.61.0507081527040.3743@scrub.home>
Date: Fri, 08 Jul 2005 19:17:47 +0300
Message-Id: <1120839467.18988.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-08 at 15:34 +0200, Roman Zippel wrote:
> Are the advantages big enough to actively discourage defines? It's nice 
> that you do reviews, but please leave some room for personal preferences. 
> If the code is correct and perfectly readable, it doesn't matter whether 
> to use defines or enums. Unless you also intent to also debug and work 
> with that code, why don't leave the decision to the author?

I think the advantages are big enough. Also, in my experience, it is
usually not a conscious decision by the author. But if you and other
developers think my enum pushing is too much, I can tone it down :).

			Pekka

