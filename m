Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266907AbTADNwy>; Sat, 4 Jan 2003 08:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266924AbTADNwy>; Sat, 4 Jan 2003 08:52:54 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:29966 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S266907AbTADNwx>; Sat, 4 Jan 2003 08:52:53 -0500
Date: Sat, 4 Jan 2003 15:00:58 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][FBDEV]: fb_putcs() and fb_setfont() methods
Message-ID: <20030104140058.GA10918@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <1041672313.958.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041672313.958.17.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antonino Daplas <adaplas@pol.net>
Date: Sat, Jan 04, 2003 at 05:25:14PM +0800
> Attached is a patch against 2.5.54 in an attempt to add putcs() and
> setfont() methods for fbdev drivers that require them:
> 
And those drivers would be the matrox framebuffer drivers, for example?

That would be really great!

Thanks,
Jurriaan
-- 
Me I'm just like you
I don't have a clue
	Shotgun Messiah - Nobody's Home
GNU/Linux 2.5.53 SMP/ReiserFS 2x2752 bogomips 7 users load av: 2.24 1.99 1.56
