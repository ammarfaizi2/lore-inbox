Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265382AbTAJOIs>; Fri, 10 Jan 2003 09:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbTAJOIs>; Fri, 10 Jan 2003 09:08:48 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:21688 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id <S265382AbTAJOIr>; Fri, 10 Jan 2003 09:08:47 -0500
Date: Fri, 10 Jan 2003 15:17:29 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21pre3-ac2
Message-ID: <20030110141729.GA31123@charite.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200301090139.h091d9G26412@devserv.devel.redhat.com> <20030110094504.GM25979@charite.de> <1042200029.28469.55.camel@irongate.swansea.linux.org.uk> <20030110111547.GB18007@charite.de> <20030110133028.GB12071@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030110133028.GB12071@charite.de>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>:

> Backing out of mm/shmem.c makess thee bug disappear.

Not really. I rebooted and then the ac2 crashed DURING a fsck that was
caused by reaching the maximum mount count.
I'm outta here and back to 2.4.21pre3 :)

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916


