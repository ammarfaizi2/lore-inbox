Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbUAZJsV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 04:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263491AbUAZJsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 04:48:21 -0500
Received: from tekla.ing.umu.se ([130.239.117.80]:31906 "EHLO tekla.ing.umu.se")
	by vger.kernel.org with ESMTP id S263260AbUAZJsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 04:48:17 -0500
Date: Mon, 26 Jan 2004 10:48:15 +0100
From: Tomas Ogren <stric@ing.umu.se>
To: linux-kernel@vger.kernel.org
Subject: Re: Fried the onboard Broadcom 4401 network...
Message-ID: <20040126094815.GA2060@ing.umu.se>
Mail-Followup-To: Tomas Ogren <stric@ing.umu.se>,
	linux-kernel@vger.kernel.org
References: <20040125024238.GA10424@ing.umu.se> <20040126090859.GB505@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040126090859.GB505@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
X-System: Linux tekla 2.4.24-rc1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 January, 2004 - Pavel Machek sent me these 0,4K bytes:

> Hi!
> 
> > After that, I have not been able to get link (neither see it through
> > Linux/WinXP or the physical LED). I have tried multiple cables and my
> > laptop is perfectly happy with all of them, but the broadcom thingie
> > seems not. The switch doesn't see link either.
> 
> Try to physically unplug machine from AC for a while.

Ah, thank you! Just turning the power switch off didn't help.. I suppose
it's kept alive (for some values of alive ;) for WOL and such..

Now it's working again.

/Tomas
-- 
Tomas Ögren, stric@ing.umu.se, http://www.ing.umu.se/~stric/
|- Student at Computing Science, University of Umeå
`- Sysadmin at {cs,ing,acc}.umu.se
