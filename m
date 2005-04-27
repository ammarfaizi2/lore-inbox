Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbVD1SOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVD1SOu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 14:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbVD1SOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 14:14:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53433 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262204AbVD1SLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 14:11:50 -0400
Date: Wed, 27 Apr 2005 22:35:58 +0200
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <gregkh@suse.de>
Cc: erik@debian.franken.de, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [04/07] partitions/msdos.c fix
Message-ID: <20050427203558.GE2226@openzaurus.ucw.cz>
References: <20050427171446.GA3195@kroah.com> <20050427171627.GE3195@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427171627.GE3195@kroah.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> -stable review patch.  If anyone has any objections, please let us know.

Well, patch author says it should go to mm...:

> I think nobody uses such partitions seriously, but nevertheless this should
> probably live in -mm for a while to see if anybody complains.

...seems like enough not to let it into .8...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

