Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbUJYMRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbUJYMRk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 08:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbUJYMRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 08:17:40 -0400
Received: from quechua.inka.de ([193.197.184.2]:45519 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261773AbUJYMRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 08:17:38 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20041024181757.GA28994@sapience.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CM3n6-0003ad-00@calista.eckenfels.6bone.ka-ip.net>
Date: Mon, 25 Oct 2004 14:17:36 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20041024181757.GA28994@sapience.com> you wrote:
>   I wonder what interest there might would be in an open source 
>   one-time-password secure id type card? 

Yes, I would like to see that also. Maybe a USB Dongle with display. That
will require only small and simple components.
> 
>   Not sure how easy it would be to make reset/resync the card to
>   the server random sequence via something - serial/usb/ethernet?

Better do it like RSA, keep resync records in the server and not allow any
electronical interaction with the tokens.

>   Something like an rsa secureid card but open source server?
>   I am sure community could help program the server side?

I think there are actually enough OTP Implementations out there, which can
be somewhat abused. Personally I would love to see a simple opie
entry/output device with no clocking at all.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
