Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263225AbUEBT4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbUEBT4Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 15:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbUEBT4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 15:56:01 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:31887 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S263219AbUEBTzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 15:55:53 -0400
Date: Sun, 2 May 2004 21:55:47 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3, nvidia.o and CONFIG_4KSTACKS
Message-ID: <20040502195547.GK31188@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <4094F005.5000501@poggs.co.uk> <20040502144825.GH26906@charite.de> <40955039.90909@poggs.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40955039.90909@poggs.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Hicks <peter.hicks@poggs.co.uk>:

> In the patch on kernel.org for 2.6.6-rc3?  Is it in the help text? 

It used to be.

> I can't see anything in the "make menuconfig" help text that warns of
> breakage :\

Interesting. I can't see it now. When it was first introduced in the
mm kernels, it had something like "Note: this may break binary drivers".

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
IT-Zentrum Standort Campus Mitte                          AIM.  ralfpostfix
