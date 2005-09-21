Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbVIURS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbVIURS2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVIURS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:18:28 -0400
Received: from albireo.ucw.cz ([84.242.65.108]:40899 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S1751263AbVIURS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:18:27 -0400
Date: Wed, 21 Sep 2005 19:18:23 +0200
From: Martin Mares <mj@ucw.cz>
To: thockin@hockin.org
Cc: "Shawn M. Campbell" <scampbell@malone.edu>, linux-kernel@vger.kernel.org
Subject: Re: PCI Express or TG3 issue
Message-ID: <20050921171823.GA7309@ucw.cz>
References: <433182C8.2060006@malone.edu> <20050921172156.GA31339@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050921172156.GA31339@hockin.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >         Region 0: Memory at <ignored> (64-bit, non-prefetchable)
>                     ^^^^^^^^^^^^^^^^^^
> 		    Problem.
> 
> hexdump /proc/bus/pci/02/00.0 and send it here.

Or `lspci -vvbx'.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"Beware of bugs in the above code; I have only proved it correct, not tried it." -- D.E.K.
