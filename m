Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262123AbVCAXdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbVCAXdL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 18:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbVCAXdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 18:33:10 -0500
Received: from gprs215-167.eurotel.cz ([160.218.215.167]:11177 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262123AbVCAXcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 18:32:43 -0500
Date: Wed, 2 Mar 2005 00:32:28 +0100
From: Pavel Machek <pavel@suse.cz>
To: Michael Schroeder <mls@suse.de>
Cc: Michal Januszewski <spock@gentoo.org>, linux-kernel@vger.kernel.org
Subject: Re: Bootsplash for 2.6.11-rc4
Message-ID: <20050301233228.GE2062@elf.ucw.cz>
References: <20050218165254.GA1359@elf.ucw.cz> <20050219011433.GA5954@spock.one.pl> <20050228174015.GB1349@elf.ucw.cz> <20050301130325.GB14278@spock.one.pl> <20050301142819.GA23884@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050301142819.GA23884@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hmm, maybe I should change the vesafb test in the bootsplash code
> to test if fb_imageblit == cfb_imageblit. This would make Pavel
> very happy, I guess ;-)

Yes, I like that one. Also it is likely going to be cleaner than
vesafb_ops hack.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
