Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbTIPROR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 13:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbTIPROQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 13:14:16 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:39141 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262000AbTIPROP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 13:14:15 -0400
Date: Fri, 12 Sep 2003 13:19:41 +0200
From: Pavel Machek <pavel@suse.cz>
To: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test[45]: enable swsusp?
Message-ID: <20030912111941.GM3944@openzaurus.ucw.cz>
References: <20030911215113.GB28883@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911215113.GB28883@butterfly.hjsoft.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> what needs to be configured to get the /proc/power/state file i've
> seen mentioned around here?  i'd like to try swsusp again.  the swsusp
> docs seem a bit dated.

Look for "revert swsusp to -test3" patch on lists, then use reboot() interface
to trigger it.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

