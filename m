Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317716AbSGVSzp>; Mon, 22 Jul 2002 14:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317718AbSGVSzo>; Mon, 22 Jul 2002 14:55:44 -0400
Received: from mnh-1-07.mv.com ([207.22.10.39]:64260 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S317716AbSGVSzo>;
	Mon, 22 Jul 2002 14:55:44 -0400
Message-Id: <200207222002.PAA04143@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] UML - part 1 of 2 
In-Reply-To: Your message of "Mon, 22 Jul 2002 18:38:44 +0100."
             <20020722183844.A8526@infradead.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 22 Jul 2002 15:02:41 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hch@infradead.org said:
> The fastcall definition should go into an asm/ header instead of such
> hacks.. 

And I'm supposed to fix this as part of the UML patch?

> the disk accounting stuff is also bogus - instead of wasting ram with
> huge array it should rather be dynamically-allocated in a per-disk
> structure..

And this too?

				Jeff

