Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752069AbWJNEsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbWJNEsR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 00:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752071AbWJNEsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 00:48:17 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:30369 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1752069AbWJNEsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 00:48:16 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: bzip2 tarball 2.6.19-rc2 packaged wrong?
Date: Sat, 14 Oct 2006 14:48:07 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <5uq0j21tqjgbes7v60rlgtj7io1n99utco@4ax.com>
References: <200610132336.21392.shawn.starr@rogers.com>
In-Reply-To: <200610132336.21392.shawn.starr@rogers.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2006 23:36:20 -0400, Shawn Starr <shawn.starr@rogers.com> wrote:

>Linus, something in git  broke the prepackaged tarball/bzip2 generation?
>
>$ tar -jxvf linux-2.6.19-rc2.tar.bz2
>linux-2.6.19-rc2.gitignore
>linux-2.6.19-rc2COPYING
>linux-2.6.19-rc2CREDITS
>linux-2.6.19-rc2Documentation/
>linux-2.6.19-rc2Documentation/00-INDEX
>linux-2.6.19-rc2Documentation/ABI/
>linux-2.6.19-rc2Documentation/ABI/README
>
>-rc1 was ok.
>
>Anyone else notice this?

I download and running the .bz2 patch against 2.6.18 okay, no try full 
tarball.

Grant.
