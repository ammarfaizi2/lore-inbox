Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbVKOON3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbVKOON3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 09:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVKOON3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 09:13:29 -0500
Received: from tartu.cyber.ee ([193.40.6.68]:62479 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S932415AbVKOON2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 09:13:28 -0500
From: Meelis Roos <mroos@linux.ee>
To: baldrick@free.fr, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-git1: BTTV: no picture with grabdisplay; later, an Oops
In-Reply-To: <200511151242.00047.baldrick@free.fr>
User-Agent: tin/1.7.10-20050815 ("Grimsay") (UNIX) (Linux/2.6.14-g741b2252 (i686))
Message-Id: <20051115141305.049CF14200@rhn.tartu-labor>
Date: Tue, 15 Nov 2005 16:13:05 +0200 (EET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DS> When I change channels, a picture flashes onto the screen for a fraction of
DS> a second, then the screen becomes black.  The picture glimpsed seems to be =
DS> four
DS> copies of the tv show, arranged in a 2x2 matrix.

Similar "Bad address" and "Invalid argument" errors here. xawtv works
but only in overlay mode. tvtime tries non-overlay and gets these
errors. Card is Hauppauge WinTV with bt878. 2.6.14 works.

-- 
Meelis Roos
