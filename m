Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289823AbSBOOqS>; Fri, 15 Feb 2002 09:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289824AbSBOOqJ>; Fri, 15 Feb 2002 09:46:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34569 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289823AbSBOOp4>;
	Fri, 15 Feb 2002 09:45:56 -0500
Message-ID: <3C6D1F21.E0034BEE@mandrakesoft.com>
Date: Fri, 15 Feb 2002 09:45:53 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: elsner@zrz.TU-Berlin.DE
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
In-Reply-To: <E16bhwo-0007GZ-00@bronto.zrz.TU-Berlin.DE> <3C6D07B9.596AD49E@mandrakesoft.com> <20020215153604.A29642@stud.ntnu.no>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Langås wrote:
> 
> Jeff Garzik:
> > DaveM and I should have something eventually, which will make the
> > RH-shipped driver irrelevant.
> 
> How's this coming along?  Do you have specs which are free?  Ie. could
> others get the specs too?  (Contacting broadcom doesn't help, I've tried
> that).

I wish.  The only info source we have is their latest GPL'd driver.

It's coming along slowly at the moment... I haven't had time to mess
with it for a few months, and I not DaveM was originally supposed to be
filling in the rx/tx dma stuff, and h/w init.  DaveM jumped in recently
and played a bit with the h/w init stage.

My guess is maybe another month or two until others can play with
"tg3"...

	Jeff


-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
