Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265197AbTCEK5q>; Wed, 5 Mar 2003 05:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265250AbTCEK5q>; Wed, 5 Mar 2003 05:57:46 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:4360 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S265197AbTCEK5q>; Wed, 5 Mar 2003 05:57:46 -0500
Date: Wed, 5 Mar 2003 14:06:33 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: kuznet@ms2.inr.ac.ru
Cc: torvalds@transmeta.com, raarts@office.netland.nl,
       david.knierim@tekelec.com, alexander@netintact.se, becker@scyld.com,
       greg@kroah.com, hadi@cyberus.ca, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, Robert.Olsson@data.slu.se
Subject: Re: PCI init issues
Message-ID: <20030305140633.A8074@jurassic.park.msu.ru>
References: <20030305014656.B678@localhost.park.msu.ru> <200303042312.CAA06199@sex.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200303042312.CAA06199@sex.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Wed, Mar 05, 2003 at 02:12:50AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 02:12:50AM +0300, kuznet@ms2.inr.ac.ru wrote:
> So, maybe the workaround is in znyx driver for XP. :-)

Quite possible.

> BIOSes were fixed to understand the first level bridges,
> but I guess none of them construct correct tables
> for second level bridges.

OTOH, there are rumors that PCI resource management has been
vastly improved in XP. I believe Alan and Russell tried that
with rather long chain of of bridges using PCI expansion
chassis and windows had no problems with it.
Not sure about details though (i.e. what version of windows
and whether additional drivers were required or not).

Ivan.
