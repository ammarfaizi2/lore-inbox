Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269901AbRHJDji>; Thu, 9 Aug 2001 23:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269904AbRHJDj2>; Thu, 9 Aug 2001 23:39:28 -0400
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:10112 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S269903AbRHJDjU>; Thu, 9 Aug 2001 23:39:20 -0400
Message-ID: <3B73564D.9F6A8756@randomlogic.com>
Date: Thu, 09 Aug 2001 20:34:37 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: Q: Kernel patching
In-Reply-To: <3B733C28.EE0C5D4@randomlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul G. Allen" wrote:
> 
> I've never applied a patch to a kernel before, so please bear with me.
> 
> Applying patch-2.4.7-ac10 to kernel 2.4.7 I get many messages such as
> this:
> 
> 1 out of 1 hunk ignored -- saving rejects to file
> include/asm-um/segment.h.rej
> The next patch would create the file include/asm-um/semaphore.h,
> which already exists!  Skipping patch.
> 

OK, I got it to work. My mistake was trying to use patch-kernel instead
of just patch.

PGA

-- 
Paul G. Allen
UNIX Admin II/Network Security
Akamai Technologies, Inc.
www.akamai.com
