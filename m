Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbTIHNZc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 09:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbTIHNYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 09:24:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48605 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262208AbTIHNYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 09:24:01 -0400
Date: Wed, 3 Sep 2003 07:45:39 +0200
From: Pavel Machek <pavel@suse.cz>
To: Micha Feigin <michf@post.tau.ac.il>
Cc: Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3+bk: ACPI does not switch off the computer
Message-ID: <20030903054539.GL1358@openzaurus.ucw.cz>
References: <20030822062945.GA1128@steel.home> <1061581183.3498.5.camel@litshi.luna.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061581183.3498.5.camel@litshi.luna.local>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The solution was to change the sleep level for ACPI when turnign of from
> S5 to S4 (don't know why this works). In the file 
> 
S4 and S5 are very similar; no wonder this works.

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

