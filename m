Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261385AbSIWTad>; Mon, 23 Sep 2002 15:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbSIWSlg>; Mon, 23 Sep 2002 14:41:36 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27041 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261310AbSIWSlZ>;
	Mon, 23 Sep 2002 14:41:25 -0400
Date: Mon, 23 Sep 2002 09:00:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Peter Rival <frival@zk3.dec.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ALPHA] Compile fixes for alpha arch
In-Reply-To: <Pine.LNX.4.44.0209232100430.2994-200000@apples.zk3.dec.com>
Message-ID: <Pine.LNX.4.44.0209230852550.13675-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Sep 2002, Peter Rival wrote:
> 
> And if pine screws up this attachment, I'm gonna...something...

Not screwed up, but it's BASE64-encoded. Which means that I can't just 
apply the email, I have to separately save the attachment etc, and I can't 
reply to the email and have my mail client include the quoted attachment 
in the reply (needed if I need to point some problem with the patch etc).

This is why I absolutely abhor attachments - they add zero value (over a 
well-behaving mail app), and they make some things basically impossible to 
do conveniently.

I've applied the patch, but please try to get a fixed mail client. A 
normal "read file" in pine will do it with almost all versions of pine 
(some versions are broken and will strip whitespace from the end of lines, 
stupid).

Alternatively, if you use attachments, if the mailer doesn't re-code them 
as something stupid (ie leaves the encoding as plain ascii), then that 
works too.

			Linus

