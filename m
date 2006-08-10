Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbWHJV1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWHJV1A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 17:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWHJV1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 17:27:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51470 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750803AbWHJV07
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 17:26:59 -0400
Date: Thu, 10 Aug 2006 21:26:47 +0000
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: linux-kernel@vger.kernel.org, Robert Love <rlove@rlove.org>,
       Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 06/12] hdaps: Limit hardware query rate
Message-ID: <20060810212646.GA4183@ucw.cz>
References: <1155203330179-git-send-email-multinymous@gmail.com> <11552033701218-git-send-email-multinymous@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11552033701218-git-send-email-multinymous@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The polling rate is increased to 50Hz, as needed by the hdaps daemon.
> A later patch makes this configurable.

So you have a daemon that will actually protect the harddrive? Do you
have an url? That would be great, particulary for poor users of
misdesigned x41 (that seem to kill disk every 6 months without this
kind of protection...)
							Pavel

-- 
Thanks for all the (sleeping) penguins.
