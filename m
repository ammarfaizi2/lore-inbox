Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWBMOY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWBMOY1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 09:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWBMOY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 09:24:27 -0500
Received: from mail.gmx.de ([213.165.64.21]:2776 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751265AbWBMOY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 09:24:26 -0500
X-Authenticated: #428038
Date: Mon, 13 Feb 2006 15:24:23 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060213142423.GF10566@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20060210114721.GB20093@merlin.emma.line.org> <43EC887B.nailISDGC9CP5@burner> <mj+md-20060210.123726.23341.atrey@ucw.cz> <43EC8E18.nailISDJTQDBG@burner> <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr> <43EC93A2.nailJEB1AMIE6@burner> <20060210141651.GB18707@thunk.org> <43ECA3FC.nailJGC110XNX@burner> <Pine.LNX.4.61.0602121101070.25363@yvahk01.tjqt.qr> <43F092BB.nailKUSH1YIP1@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F092BB.nailKUSH1YIP1@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-13:

> But as a note: st_rdev from the device carrying the FS becomes st_dev
> for all files inside a particular FS.

This doesn't yield any further guarantees, and beyond that is utterly
irrelevant as the device in question is not mounted at all, so this
connection remains invisible.

This is just the usual Schily Distraction Maneuvre.

-- 
Matthias Andree
