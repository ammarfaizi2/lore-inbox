Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbULKWCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbULKWCl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 17:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbULKWCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 17:02:40 -0500
Received: from 90.Red-213-97-199.pooles.rima-tde.net ([213.97.199.90]:26073
	"HELO fargo") by vger.kernel.org with SMTP id S262024AbULKWCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 17:02:31 -0500
Date: Sat, 11 Dec 2004 23:01:38 +0100
From: David =?iso-8859-15?Q?G=F3mez?= <david@pleyades.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Simos Xenitellis <simos74@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: Improved console UTF-8 support for the Linux kernel?
Message-ID: <20041211220138.GE14168@fargo>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Simos Xenitellis <simos74@gmx.net>, linux-kernel@vger.kernel.org
References: <1102784797.4410.8.camel@kl> <20041211173032.GA13208@fargo> <Pine.LNX.4.53.0412112002020.30929@yvahk01.tjqt.qr> <20041211212533.GA13739@fargo> <Pine.LNX.4.53.0412112234550.2492@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53.0412112234550.2492@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan ;),

On Dec 11 at 10:39:55, Jan Engelhardt wrote:
> Yes it does generate 0xC3B6 (otherwise it would show up as garbage, because it
> would not be utf8-compliant if it only output 0xF6)
> 
> >I'm using kernel 2.6.9 + Chris patch
> 
> I am using SUSE's KOTD 20041202 (2.6.8 + 2.6.9-rc2)

Maybe the patch or a fix has already been included in rc2/rc3, or in
SUSE's version :??

> >method. I've used it with anthy, just have to check it with skk.
> 
> Have not seen it. What is it? Some sort of xterm?

Just an input system. To be able to write Japanese all over the place ;))

regards,

-- 
David Gómez                                      Jabber ID: davidge@jabber.org
