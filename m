Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWF2LgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWF2LgP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 07:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWF2LgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 07:36:15 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64704 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750930AbWF2LgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 07:36:14 -0400
Date: Thu, 29 Jun 2006 11:42:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Daniel Walker <dwalker@dwalker1.mvista.com>
Cc: tglx@linutronix.de, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: NO_HZ Kconfig rework
Message-ID: <20060629094231.GA2009@elf.ucw.cz>
References: <200606261616.k5QGGbem016569@dwalker1.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606261616.k5QGGbem016569@dwalker1.mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2006-06-26 09:16:37, Daniel Walker wrote:
> I got NO_HZ working on ARM, but because the ARM tree already
> extensively implements NO_IDLE_HZ I had to make NO_HZ a
> completely seprate option.

So... what is the difference between NO_HZ and NO_IDLE_HZ?
							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
