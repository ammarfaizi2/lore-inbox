Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbTETPfb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 11:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263825AbTETPfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 11:35:31 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:3011 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263824AbTETPf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 11:35:29 -0400
Date: Tue, 20 May 2003 16:51:38 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Brett <generica@email.com>
Cc: linux-kernel@vger.kernel.org, jsimmons@infradead.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: CONFIG_VIDEO_SELECT stole my will to live
Message-ID: <20030520155138.GA29450@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Brett <generica@email.com>, linux-kernel@vger.kernel.org,
	jsimmons@infradead.org, linux-fbdev-devel@lists.sourceforge.net
References: <Pine.LNX.4.44.0305210002210.19743-100000@bad-sports.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305210002210.19743-100000@bad-sports.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 12:14:50AM +1000, Brett wrote:

 > since 2.5.67-bk5. I have been unable to boot my laptop
 > tonight, I finally traced it back to
 > http://linux.bkbits.net:8080/linux-2.5/cset@1.1006

good work.

 > the video card is a chips and tech 65545
 > i'd just like to know where to go from here, so that I can return to 
 > booting with CONFIG_VIDEO_SELECT set 

Possibly the card's VGA BIOS has 'issues' with that call.

Wasn't the EDID stuff getting backed out anyways ?

		Dave
