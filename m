Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbTBTOkk>; Thu, 20 Feb 2003 09:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264628AbTBTOkk>; Thu, 20 Feb 2003 09:40:40 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:38321 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262796AbTBTOkj>;
	Thu, 20 Feb 2003 09:40:39 -0500
Date: Thu, 20 Feb 2003 15:02:01 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: FBdev updates.
Message-ID: <20030220150201.GD13507@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	James Simmons <jsimmons@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44.0302200108090.20350-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302200108090.20350-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 01:09:33AM +0000, James Simmons wrote:

 > New updates to the fbdev layer. You can grab the diff from 
 > http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

James,
 Whats the current status with matroxfb ? Its been broken
for months now, and hasn't seen any progress wrt getting it
back on its feet.

I understand Petr had some concerns with the new API, but
*something* needs to be done to get this back up and running.

I'd understand if this was a neglected hardly-used-by-anyone
driver, but there's an awful lot of matrox cards out there.

This was first reported broken way back in 2.5.53, but I believe
was broken even longer before that.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
