Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266237AbUHDPEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266237AbUHDPEH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 11:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266242AbUHDPEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 11:04:07 -0400
Received: from tarjoilu.luukku.com ([194.215.205.232]:23777 "EHLO
	tarjoilu.luukku.com") by vger.kernel.org with ESMTP id S266237AbUHDPEF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 11:04:05 -0400
Message-ID: <4110FB0E.230CE613@users.sourceforge.net>
Date: Wed, 04 Aug 2004 18:04:46 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, James Morris <jmorris@redhat.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.8-rc3
References: <Pine.LNX.4.58.0408031505470.24588@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Summary of changes from v2.6.8-rc2 to v2.6.8-rc3
[snip]
> James Morris:
>   o [CRYPTO]: Add i586 optimized AES

My work on aes-i586.S is only licensed under original three clause BSD
license. You do not have my permission to change the license.

Either use original license or drop this code.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
