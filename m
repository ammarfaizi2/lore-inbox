Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269884AbRHJBsM>; Thu, 9 Aug 2001 21:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269885AbRHJBsB>; Thu, 9 Aug 2001 21:48:01 -0400
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:47232 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S269884AbRHJBrr>; Thu, 9 Aug 2001 21:47:47 -0400
Message-ID: <3B733C28.EE0C5D4@randomlogic.com>
Date: Thu, 09 Aug 2001 18:43:04 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Q: Kernel patching
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've never applied a patch to a kernel before, so please bear with me.

Applying patch-2.4.7-ac10 to kernel 2.4.7 I get many messages such as
this:

1 out of 1 hunk ignored -- saving rejects to file
include/asm-um/segment.h.rej
The next patch would create the file include/asm-um/semaphore.h,
which already exists!  Skipping patch.

Is this normal?

PGA

--

Paul G. Allen
UNIX Admin II/Network Security
Akamai Technologies, Inc.
www.akamai.com
