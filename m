Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbTFBPqx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 11:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbTFBPqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 11:46:53 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48644 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262493AbTFBPqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 11:46:49 -0400
Date: Mon, 2 Jun 2003 08:59:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Juan Quintela <quintela@mandrakesoft.com>
cc: Russell King <rmk@arm.linux.org.uk>, Steven Cole <elenstev@mesatop.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function declarations.
In-Reply-To: <m2smqs7nth.fsf@neno.mitica>
Message-ID: <Pine.LNX.4.44.0306020856450.19910-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2 Jun 2003, Juan Quintela wrote:
> 
> /**
>  * foo - <put something there>
>  * @bar: number of frobnicators
>  * @baz: self-larting on or off
>  * @userdata: pointer to arbitrary userdata to be registered
>  *
>  * Description: Please, fix me
>  */
> int foo(long bar, long baz)
> {
> ...
> 
> Looks like a better alternative to me.

Hey, if somebody were to send me a patch (hint hint), I'd happily apply 
it.

		Linus

