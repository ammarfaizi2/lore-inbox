Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261845AbREPJGP>; Wed, 16 May 2001 05:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261846AbREPJGF>; Wed, 16 May 2001 05:06:05 -0400
Received: from www.topmail.de ([212.255.16.226]:5071 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S261845AbREPJFw>;
	Wed, 16 May 2001 05:05:52 -0400
From: <eccesys@topmail.de>
To: <linux-kernel@vger.kernel.org>
Cc: <dhowells@redhat.com>
Subject: Re: rwsem, gcc3 again
Message-Id: <20010516090327.4A0BFA5A9DA@www.topmail.de>
Date: Wed, 16 May 2001 11:03:27 +0200 (MET DST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,
I am using the gcc-3.0 snapshot of 14.5.2001 from codesourcery (i686 binary).
I have now tried to mimic CPU=386 behaviour (patch posted yesterday night)
and it compiles (just sound fails), by exchanging y and n in
CONFIG_RWSEM_GENERIC_SPINLOCK and CONFIG_RWSEM_XCHGADD_ALGORITHM.

Thanks for your patience, all listening...

-mirabilos
-- 
by telnet
