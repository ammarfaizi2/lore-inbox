Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268822AbTGQTyP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 15:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269219AbTGQTyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 15:54:15 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:17383 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S268822AbTGQTyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 15:54:14 -0400
Date: Thu, 17 Jul 2003 22:09:06 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1-ac2 issues / Toshiba Laptop keyboard
Message-ID: <20030717200906.GB25759@charite.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030717141847.GF7864@charite.de> <1058452714.9048.4.camel@dhcp22.swansea.linux.org.uk> <20030717144549.GL7864@charite.de> <3F16E9D6.8070705@alvie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F16E9D6.8070705@alvie.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alvaro Lopes <alvieboy@alvie.com>:

> I have the same problem here with a toshiba satellite (with 
> 2.6.0-test1).  It boots ok, then when I reboot it stops before loading 
> lilo (pure blank screen with only cursor on it). If I switch off/on it 
> goes OK.

Exactly the same here. Note: Alan, you already had to work around one
issue with that controller in the Toshiba notebooks; they wouldn't
find the disks after you added the new IDE driveres back in 2.4.20-acX.
 
-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
AIM: ralfpostfix
