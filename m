Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270428AbTGNBKV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 21:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270480AbTGNBKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 21:10:21 -0400
Received: from ns2.eclipse.net.uk ([212.104.129.133]:61959 "EHLO
	smtp2.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S270428AbTGNBKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 21:10:20 -0400
From: Ian Hastie <ianh@iahastie.clara.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.75 freeze when booting
Date: Mon, 14 Jul 2003 02:21:42 +0100
User-Agent: KMail/1.5.2
References: <Pine.LNX.4.56.0307132310490.19479@www.polycon.fi>
In-Reply-To: <Pine.LNX.4.56.0307132310490.19479@www.polycon.fi>
Cc: Lasse Anderson <laa@polycon.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307140221.47173.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 Jul 2003 21:25, Lasse Anderson wrote:
> I boot up the machine and see the three first rows after lilo,
> "uncompressing linux" and then "booting the kernel". After that nothing
> happens. The kernel configuration can be found at
> http://www.polycon.fi/~laa/config-2.5.75
>
> 4.
> Kernel version 2.5.75


> Gnu C                  3.3.1

I get this too when I compile with that version of GCC.  When I compile with 
GCC 2.95.4 it works OK.  In Debian you can do this by chaning the definitions 
of CC, HOSTCC, and HOSTCXX to gcc-2.95 and g++-2.95 as appropriate.

-- 
Ian.

