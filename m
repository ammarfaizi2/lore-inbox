Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265776AbUHNU5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265776AbUHNU5Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 16:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265782AbUHNU5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 16:57:15 -0400
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:6863 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S265776AbUHNU5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 16:57:13 -0400
Date: Sat, 14 Aug 2004 15:57:07 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.8 - Oops on NFSv3
Message-ID: <20040814205707.GA11936@yggdrasil.localdomain>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0408132303090.5277@ppc970.osdl.org> <20040814101039.GA27163@alpha.home.local> <Pine.LNX.4.58.0408140336170.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408140344110.1839@ppc970.osdl.org> <20040814115548.A19527@infradead.org> <Pine.LNX.4.58.0408140404050.1839@ppc970.osdl.org> <411E0A37.5040507@anomalistic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411E0A37.5040507@anomalistic.org>
X-Operating-System: Linux yggdrasil 2.6.8-rc4 #1 SMP Thu Aug 12 17:22:13 CDT 2004 i686 GNU/Linux
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2004 at 08:48:55PM +0800, Nur Hussein wrote:
> I hear the first victim of the breakage may be the kernel.org front 
> page. 2.6.8.1 is not showing up as "latest".

The `patch-kernel' script needs updating as well.

   $ scripts/patch-kernel . ~/kernel/
   Current kernel version is 2.6.0
   Applying patch-2.6.1 (bzip2)... done.
   Applying patch-2.6.2 (bzip2)... done.
   Applying patch-2.6.3 (bzip2)... done.
   Applying patch-2.6.4 (bzip2)... done.
   Applying patch-2.6.5 (bzip2)... done.
   Applying patch-2.6.6 (bzip2)... done.
   Applying patch-2.6.7 (bzip2)... done.
   Applying patch-2.6.8 (bzip2)... done.
