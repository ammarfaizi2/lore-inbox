Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbVKTByO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbVKTByO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 20:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbVKTByO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 20:54:14 -0500
Received: from smtpout1.uol.com.br ([200.221.4.192]:16882 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S1751136AbVKTByO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 20:54:14 -0500
Date: Sat, 19 Nov 2005 23:54:00 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: Does Linux support powering down SATA drives?
Message-ID: <20051120015359.GD20828@ime.usp.br>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
References: <437F63C1.6010507@perkel.com> <1132426887.19692.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1132426887.19692.11.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 19 2005, Alan Cox wrote:
> On Sad, 2005-11-19 at 09:41 -0800, Marc Perkel wrote:
> > Trying to save power consumption.
> 
> SATA not yet, USB you could however.

And what about Firewire? I see that MacOS X automatically spins down the
drive when I unmount it from a Mac.

Would it be possible to have this feature available for userspace (where
I would think would be the proper place for the policy controlling this
thing)?


Thanks for any comments, Rogério Brito.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
