Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWIUWTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWIUWTz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbWIUWTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:19:54 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:6634 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932065AbWIUWTy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:19:54 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Mark Haverkamp <markh@osdl.org>
Subject: Re: 2.6.18-rc7-mm1
Date: Fri, 22 Sep 2006 00:19:44 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060919012848.4482666d.akpm@osdl.org> <1158872854.7064.22.camel@markh3.pdx.osdl.net>
In-Reply-To: <1158872854.7064.22.camel@markh3.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609220019.45212.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 September 2006 23:07, Mark Haverkamp wrote:
> Here is a patch that fixes the compile errors.  I took the code from
> misc_32.S.  
> 
> Signed-off-by: Mark Haverkamp <markh@osdl.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I must have missed this one because I went through all architectures
that have an include/asm-*/unistd.h file, which ppc no longer has
since the consolidation of arch/powerpc.

	Arnd <><
