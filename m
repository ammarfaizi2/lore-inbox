Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269269AbRGaMI3>; Tue, 31 Jul 2001 08:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269272AbRGaMIU>; Tue, 31 Jul 2001 08:08:20 -0400
Received: from ns.suse.de ([213.95.15.193]:21765 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S269269AbRGaMIJ>;
	Tue, 31 Jul 2001 08:08:09 -0400
Date: Tue, 31 Jul 2001 14:07:28 +0200 (CEST)
From: Rainer Link <link@suse.de>
To: Chris Crowther <chrisc@shad0w.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: OT: Re: Test mail
In-Reply-To: <Pine.LNX.4.33.0107301043100.18360-100000@monolith.shad0w.org.uk.suse.lists.linux.kernel>
Message-ID: <Pine.LNX.4.33.0107311400530.2870-100000@D180.suse.de>
Organisation: SuSE GmbH - http://www.suse.de/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On 30 Jul 2001, Chris Crowther wrote:

[cut]

> 	It got caught by my AMaViS scan - apparently it's Worm.Music.
> 	Erm, appologise to everyone if it send the alert to the list - it

No, this should not happen - at least not with amavis-perl/amavisd if
"Precedence" is either bulk or list. Moreover, ./configure provides
--with-warnsender, --with-warnrecip and --with-warnadmin (by default,
--with-warnrecip is no).

> sends warning to the message sender as well...I think I might need to do
> some modification to how it picks the person to warn.
You're welcome. Please send a diff either directly to me or to our mailing
list. :-)

best regards,
Rainer Link

-- 
Rainer Link  |                SuSE - The Linux Experts
link@suse.de |    Developer of A Mail Virus Scanner (amavis.org)
www.suse.de  | Founder OpenAntiVirus Project (www.openantivirus.org)

