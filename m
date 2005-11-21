Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbVKUR0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbVKUR0V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 12:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbVKUR0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 12:26:20 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8390 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932391AbVKUR0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 12:26:19 -0500
Date: Mon, 21 Nov 2005 18:26:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rob Landley <rob@landley.net>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] make miniconfig (take 2)
Message-ID: <20051121172609.GA2642@elf.ucw.cz>
References: <200511170629.42389.rob@landley.net> <Pine.LNX.4.61.0511192338300.1609@scrub.home> <200511210015.21269.rob@landley.net> <200511211006.48289.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511211006.48289.rob@landley.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> diff -ru linux-2.6.15-rc2.old/scripts/miniconfig.sh linux-2.6.15-rc2/scripts/miniconfig.sh
> --- linux-2.6.15-rc2.old/scripts/miniconfig.sh 2005-11-21 09:36:44.000000000 -0600
> +++ linux-2.6.15-rc2/scripts/miniconfig.sh 2005-11-21 09:21:50.000000000 -0600
> @@ -0,0 +1,46 @@

I see the patch is now in mainline... unfortunately
scripts/miniconfig.sh does not seem to have execute permission.

							Pavel

-- 
Thanks, Sharp!
