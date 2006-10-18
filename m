Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161292AbWJRTTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161292AbWJRTTJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 15:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161293AbWJRTTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 15:19:09 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:54665 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161292AbWJRTTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 15:19:05 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Gabriel C <nix.or.die@googlemail.com>
Subject: Re: 2.6.19-rc2-mm1
Date: Wed, 18 Oct 2006 21:18:30 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20061016230645.fed53c5b.akpm@osdl.org> <45367210.4040507@googlemail.com>
In-Reply-To: <45367210.4040507@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610182118.31371.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 18 October 2006 20:27, Gabriel C wrote:
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm1/
> >   
> 
> Hello,
> 
> I got this build error with 2.6.19-rc2-mm1:
> 
> CHK include/linux/compile.h
> UPD include/linux/compile.h
> CC init/version.o
> LD init/built-in.o
> LD .tmp_vmlinux1
> mm/built-in.o: In function `xip_file_write':
> (.text+0x19a47): undefined reference to `filemap_copy_from_user'
> make: *** [.tmp_vmlinux1] Error 1

\metoo
