Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbTIONxV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 09:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbTIONxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 09:53:21 -0400
Received: from poup.poupinou.org ([193.253.14.96]:24839 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S261361AbTIONxQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 09:53:16 -0400
Date: Mon, 15 Sep 2003 15:53:03 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: acpi-devel@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Vaio doesn't poweroff with 2.4.22
Message-ID: <20030915135303.GH11391@poupinou.org>
References: <Pine.GSO.4.21.0309150835480.3191-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0309150835480.3191-100000@vervain.sonytel.be>
User-Agent: Mutt/1.5.4i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 08:43:56AM +0200, Geert Uytterhoeven wrote:
> 	Hi,
> 
> With 2.4.22, my Sony Vaio PCG-Z600TEK (s/600/505/ in US/JP) shows a regression
> w.r.t. power management:
>   - It doesn't poweroff anymore (screen contents are still there after the
>     powering down message)
>   - It doesn't reboot anymore (screen goes black, though)
>   - It accidentally suspended to RAM once while I was actively working on it (I
>     never managed to get suspend working, except for this `accident'). I didn't
>     see any messages about this in the kernel log.
> 


Are you able to reboot without acpi?

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
