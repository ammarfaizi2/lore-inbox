Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbTEKPgB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 11:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbTEKPgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 11:36:01 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:21460 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261706AbTEKPgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 11:36:01 -0400
Date: Sun, 11 May 2003 11:16:00 -0400
From: Ben Collins <bcollins@debian.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Atari Atyfb fixes
Message-ID: <20030511151600.GA458@phunnypharm.org>
References: <200305111030.h4BAUBhO019633@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305111030.h4BAUBhO019633@callisto.of.borg>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11, 2003 at 12:30:11PM +0200, Geert Uytterhoeven wrote:
> Atyfb fixes for Atari (got reversed in 2.5.69):
>   - Add missing allocation of default_par
>   - Kill warnings in assignments

Thanks for the Cc. The patch looked pretty safe, but I tested it on
sparc64 anyway, and it didn't break anything.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
