Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbTIYHS0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 03:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbTIYHS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 03:18:26 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48551 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261736AbTIYHSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 03:18:24 -0400
Date: Mon, 22 Sep 2003 16:20:22 +0200
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/11] input: Fix resume of PS/2 mouse
Message-ID: <20030922142021.GA11372@openzaurus.ucw.cz>
References: <1063967201965@twilight.ucw.cz> <10639672012942@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10639672012942@twilight.ucw.cz>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 
> ChangeSet@1.1343, 2003-09-19 01:18:46-07:00, petero2@telia.com
>   psmouse-base.c:
>     Fix resume of PS/2 mouse. Uses old PM interface at the moment.
> 

I'm not sure how resume using old PM code is usefull...
Well at least its usefull as documentation :-).
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

