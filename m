Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbTEZWjp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 18:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbTEZWjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 18:39:04 -0400
Received: from mcmmta2.mediacapital.pt ([193.126.240.147]:956 "EHLO
	mcmmta2.mediacapital.pt") by vger.kernel.org with ESMTP
	id S262283AbTEZWZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 18:25:37 -0400
Date: Mon, 26 May 2003 23:38:15 +0100
From: "Paulo Andre'" <fscked@iol.pt>
Subject: Re: [RFC] [PATCH] Add 'make' with no target as preferred build command
In-reply-to: <20030526203443.GA1209@mars.ravnborg.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Roman Zippel <zippel@linux-m68k.org>
Message-id: <20030526233815.42b44a61.fscked@iol.pt>
MIME-version: 1.0
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20030526182907.108fd71e.fscked@iol.pt>
 <20030526203443.GA1209@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 May 2003 22:34:43 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> If we really want this boilerplate text then bzImage should not be
> present. It is i386 centric.
> Revised patch below. Also made it a bit more readable by wrapping
> a long line.

Agreed.

> Roman Zippel cc:ed as he is the kconfig maintainer.

I apologize for not having cc'ed Roman Zippel in the first place. It
sounded like too simple a fix. My bad, and for that I'm sorry.

		Paulo
