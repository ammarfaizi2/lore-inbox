Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTFCTnu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 15:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263945AbTFCTnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 15:43:50 -0400
Received: from router.emperor-sw2.exsbs.net ([208.254.201.37]:55470 "EHLO
	sade.emperorlinux.com") by vger.kernel.org with ESMTP
	id S263861AbTFCTnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 15:43:49 -0400
From: Josh Litherland <fauxpas@sade.emperorlinux.com>
To: Mike Dresser <mdresser_l@windsormachine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux and IBM : "unauthorized" mini-PCI : TCPA updates
In-Reply-To: <Pine.LNX.4.33.0306031538590.10095-100000@router.windsormachine.com>
X-Newsgroups: mlist.linux-kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.21-pre5-ac3 (i686))
Message-Id: <20030603200213.1AE076207B@sade.emperorlinux.com>
Date: Tue,  3 Jun 2003 16:02:13 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0306031538590.10095-100000@router.windsormachine.com> you wrote:

> There was a thread here(i think) recently about wirless causing problems
> with other frequencies, and that you could only broadcast in a specific
> set of frequencies.  I assume this is related to what IBM has done.

The cards we were testing were 11b, so they wouldn't fall under the
banner of any evil frequency hopping device.  Crippling the PCI slot to
prevent use of a card that could potentially break FCC regs provided
someone uses nonexistant published specs to develop an as-yet
nonexistant driver seems a might rash, don'tcha think ?

-- 
Josh Litherland (josh@emperorlinux.com)
