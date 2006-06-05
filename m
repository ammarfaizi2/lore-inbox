Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751100AbWFENSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWFENSo (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 09:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWFENSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 09:18:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26038 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751089AbWFENSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 09:18:43 -0400
Date: Mon, 5 Jun 2006 15:17:52 +0200
From: Pavel Machek <pavel@suse.cz>
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] swsusp: allow drivers to determine between write-resume and actual wakeup
Message-ID: <20060605131752.GE2132@elf.ucw.cz>
References: <20060605091131.GE8106@htj.dyndns.org> <20060605092342.GI5540@elf.ucw.cz> <44841AA0.4060404@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44841AA0.4060404@gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 05-06-06 20:50:56, Tejun Heo wrote:
> Pavel Machek wrote:
> >If you want to know if you RESUME was after normal FREEZE or if it is
> >after reboot, there's better patch floating around to do that.
> 
> Yeap, this is what I'm interested in.  Care to give me a pointer?

David Brownell had a patch to do that. I forwarded you my reply to
that mail...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
