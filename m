Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316043AbSEZMuT>; Sun, 26 May 2002 08:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316047AbSEZMuS>; Sun, 26 May 2002 08:50:18 -0400
Received: from ns.suse.de ([213.95.15.193]:4620 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316043AbSEZMuS>;
	Sun, 26 May 2002 08:50:18 -0400
Date: Sun, 26 May 2002 14:50:18 +0200
From: Dave Jones <davej@suse.de>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: How to send GnuPG signed mail to linux-kernel and maintainers?
Message-ID: <20020526145018.H16102@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Luca Barbieri <ldb@ldb.ods.org>,
	Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <1022416147.4072.14.camel@ldb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2002 at 02:29:07PM +0200, Luca Barbieri wrote:
 > Not using digital signatures is obviously not an option since there is
 > no way to prove that a message was not authentic (if it contains a
 > trojan patch, for example). 

Just because a patch has been signed does not mean it somehow manages
to bypass peer review.

If the patch is correct, it gets applied. If it's not obviously correct,
it gets reviewed by someone more familiar with the code.

Some people have a hard enough time getting patches they believe are
legitimate features/fixes past Al Viro, Dave Miller and the likes.
The chances of a trojan patch getting past them is I would hope, extremely minimal.

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
