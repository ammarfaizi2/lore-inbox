Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281827AbRKQXfg>; Sat, 17 Nov 2001 18:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281828AbRKQXfZ>; Sat, 17 Nov 2001 18:35:25 -0500
Received: from mnh-1-21.mv.com ([207.22.10.53]:41481 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S281827AbRKQXfK>;
	Sat, 17 Nov 2001 18:35:10 -0500
Message-Id: <200111180054.TAA03342@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Rock Gordon <rockgordon@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Executing binaries on new filesystem 
In-Reply-To: Your message of "Sat, 17 Nov 2001 14:18:21 PST."
             <20011117221821.66121.qmail@web14809.mail.yahoo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 17 Nov 2001 19:54:25 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rockgordon@yahoo.com said:
> I've written a modest filesystem for fun, it works pretty ok, but when
> I try to execute binaries from it, bash says "cannot execute binary
> file" ... If I copy the same binary elsewhere, it executes perfectly.

> Does anybody have any clue ? 

Dump it into UML, and stare it with gdb until you see where the error is
coming from.

				Jeff

