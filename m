Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265093AbSLILJt>; Mon, 9 Dec 2002 06:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265102AbSLILJt>; Mon, 9 Dec 2002 06:09:49 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:62605 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265093AbSLILJs>;
	Mon, 9 Dec 2002 06:09:48 -0500
Date: Mon, 9 Dec 2002 11:14:37 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: William Knop <w_knop@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.50-ac1 mpparse -> gcc 3.0.1 segfault
Message-ID: <20021209111437.GA31468@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	William Knop <w_knop@hotmail.com>, linux-kernel@vger.kernel.org
References: <F32fiSBtAM9r5h1inen000214bb@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F32fiSBtAM9r5h1inen000214bb@hotmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2002 at 01:55:08AM -0500, William Knop wrote:
 > Hello,
 > The machine I'm working on has SMP enabled (dual 2GHZ P4 Xeon), although 
 > I've tried it on a different box with dual P3s and it's still a no go. It 
 > didn't happen on 2.5.50-vanilla, so far as I can tell (it had other compile 
 > errors wrt intermezzo, but it got past mpparse). Attached at the bottom is 
 > the make output. Any info on similar occurrences or a fix would be 
 > appreciated.

3.0.1 is now quite old, and has a number of issues. Try a more recent gcc,
and if the problem is repeatable, file a bug with the gcc folks, as the
output told you to.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
