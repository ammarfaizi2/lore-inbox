Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262600AbTCTVWd>; Thu, 20 Mar 2003 16:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262611AbTCTVWd>; Thu, 20 Mar 2003 16:22:33 -0500
Received: from motgate2.mot.com ([136.182.1.10]:23525 "EHLO motgate2.mot.com")
	by vger.kernel.org with ESMTP id <S262600AbTCTVWd>;
	Thu, 20 Mar 2003 16:22:33 -0500
Subject: Re: [patch] oprofile for ppc
From: Andy Fleming <afleming@motorola.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: oprofile-list@lists.sourceforge.net, linuxppc-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200303070929.h279TGTu031828@saturn.cs.uml.edu>
References: <200303070929.h279TGTu031828@saturn.cs.uml.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1048195962.1110.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-1a) 
Date: 20 Mar 2003 15:32:42 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-07 at 03:29, Albert D. Cahalan wrote:
> This is basic timer profiling for ppc, tested on the
> 2.5.62 linuxppc kernel. It's a port of the ppc64 code.

I can't seem to find profile_hook() anywhere in the kernel source.  Did
it get implemented?  It looks like the ppc64 code could be copied
directly.  Without it, the kernel as patched doesn't build.  Well, at
least the 2.5.59 kernel doesn't have it.  Is it in the 2.5.62 kernel?

Andy Fleming

