Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130461AbRCLQJj>; Mon, 12 Mar 2001 11:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130472AbRCLQJ3>; Mon, 12 Mar 2001 11:09:29 -0500
Received: from [209.81.55.2] ([209.81.55.2]:55824 "EHLO cyclades.com")
	by vger.kernel.org with ESMTP id <S130461AbRCLQJY>;
	Mon, 12 Mar 2001 11:09:24 -0500
Date: Mon, 12 Mar 2001 08:08:29 -0800 (PST)
From: Ivan Passos <lists@cyclades.com>
To: Andrey Panin <pazke@orbita.don.sitek.net>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Re: [PATCH] /drivers/char/cyclades.c: panic() call removal
In-Reply-To: <20010311164747.A332@debian>
Message-ID: <Pine.LNX.4.10.10103120719420.17833-100000@main.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 11 Mar 2001, Andrey Panin wrote:
> 
> this patch removes panic() calls and adds MODULE_DEVICE_TABLE to 
> cyclades driver.

Patch looks good. Thanks for the patch, Andrey!

However: Linus, please do not apply this yet. I'll do tests with a new
Cyclades driver version we're about to release, and then I'll submit
patches to the Cyclades driver once the tests are done (and they'll
include Andrey's patch).

Later,
Ivan

