Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264237AbTEGTxd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264242AbTEGTxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:53:33 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:5800 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264237AbTEGTxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:53:32 -0400
Date: Wed, 7 May 2003 15:35:12 -0400
From: Ben Collins <bcollins@debian.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       James Simmons <jsimmons@infradead.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.69
Message-ID: <20030507193512.GV679@phunnypharm.org>
References: <Pine.LNX.4.44.0305041739020.1737-100000@home.transmeta.com> <Pine.GSO.4.21.0305072138510.12013-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0305072138510.12013-100000@vervain.sonytel.be>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 09:44:08PM +0200, Geert Uytterhoeven wrote:
> On Sun, 4 May 2003, Linus Torvalds wrote:
> > Summary of changes from v2.5.68 to v2.5.69
> > ============================================
> > 
> > Ben Collins:
> >   o [VIDEO]: Revert cfbimgblt.c back to a working state on 64-bit
> >   o [VIDEO]: Revert atyfb back to known working clean base
> 
> For future changes, could you please run these `reversals' through 
> linux-fbdev-devel, instead of silently passing them behind our backs? Thanks!

This was far from silent. These were discussed with James, DaveM and
Linus, and agreed to by James.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
