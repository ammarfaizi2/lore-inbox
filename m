Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWHHMuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWHHMuY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 08:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWHHMuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 08:50:17 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39943 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S964848AbWHHMt5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 08:49:57 -0400
Date: Tue, 8 Aug 2006 12:47:50 +0000
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Robert Love <rlove@rlove.org>, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 12/12] hdaps: Simplify whitelist
Message-ID: <20060808124750.GJ4540@ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548493143575-git-send-email-multinymous@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11548493143575-git-send-email-multinymous@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The hdaps driver can now reliably detect accelerometer hardware, as a 
> free bonus from switch to thinkpad_ec. The whitelist is thus needed 
> only for overriding the default axis configuratrion. This patch simplifies
> the whitelist to reflect this. Behavior on previously working modules is
> completely unaffected, and new models will work automatically (though not
> necessarily with correct axis configuration).
> 
> Signed-off-by: Shem Multinymous <multinymous@gmail.com>

Looks ok.

Signed-off-by: Pavel Machek <pavel@suse.cz>

-- 
Thanks for all the (sleeping) penguins.
