Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292768AbSBZUJz>; Tue, 26 Feb 2002 15:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292778AbSBZUJq>; Tue, 26 Feb 2002 15:09:46 -0500
Received: from smtp3.cern.ch ([137.138.131.164]:24801 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S292768AbSBZUJe>;
	Tue, 26 Feb 2002 15:09:34 -0500
To: Jason Lunz <j@trellisinc.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
In-Reply-To: <E16bhwo-0007GZ-00@bronto.zrz.TU-Berlin.DE> <3C6D07B9.596AD49E@mandrakesoft.com> <20020215150342.GA4347@trellisinc.com>
From: Jes Sorensen <jes@sunsite.dk>
Date: 26 Feb 2002 21:09:11 +0100
In-Reply-To: Jason Lunz's message of "Fri, 15 Feb 2002 10:03:42 -0500"
Message-ID: <d3it8kuhso.fsf@lxplus049.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Lunz <j@trellisinc.com> writes:

> In mlist.linux-kernel, you wrote:
> > Cuz the driver is a piece of crap, and BroadCom isn't interested in
> > working with the open source community to fix up the issues.
> 
> Can you elaborate? What are the issues? I've found the broadcomm driver
> to be more robust than the in-kernel one for acenic cards. With acenic,
> I've had a null-pointer deref on SMP and other lockups where I wasn't
> lucky enough to get an oops.

Ehm, it would be nice to get some more details on this. Few people
have reported problems with the acenic driver for a long time, except
for certain highmem configs and a problem with very old Tigon I cards.

Jes
