Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWIDMd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWIDMd5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWIDMdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:33:55 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45063 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S964859AbWIDMdu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:33:50 -0400
Date: Sun, 3 Sep 2006 11:09:56 +0000
From: Pavel Machek <pavel@suse.cz>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bogofilter at VGER.. (part 2)
Message-ID: <20060903110955.GE4884@ucw.cz>
References: <20060901125153.GC16047@mea-ext.zmailer.org> <20060902124626.GF16047@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060902124626.GF16047@mea-ext.zmailer.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > We are considering of taking Bogofilter into use at VGER.
> > So far we are using it in TEST mode - to teach it about
> > SPAM and HAM.
> 
> Now after some 30 hour message flow for training the filter
> has been taken into active use.
> 
> It is now able to REJECT things it considers SPAM.

Nice, but...

> VGER BF report: U 0.5
...
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html> -
> Please read the FAQ at  http://www.tux.org/lkml/

The list signature is getting long and boooring. Can we move 'vger bf
report' to X-bogo-report, and only have one FAQ pointer?
-- 
Thanks for all the (sleeping) penguins.

-- 
VGER BF report: H 0.284667
