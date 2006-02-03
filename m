Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422633AbWBCSpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422633AbWBCSpz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422639AbWBCSpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:45:55 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:25618 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1422633AbWBCSpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:45:54 -0500
Date: Fri, 3 Feb 2006 19:45:53 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060203184553.GA73763@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org
References: <20060202161853.GB8833@voodoo> <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com> <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo> <43E27792.nail54V1B1B3Z@burner> <787b0d920602021827m4890fbf4j24d110dc656d2d3a@mail.gmail.com> <43E374CF.nail5CAMKAKEV@burner> <20060203155349.GA9301@voodoo> <20060203180421.GA57965@dspnet.fr.eu.org> <20060203181314.GA21410@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203181314.GA21410@vrfy.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 07:13:14PM +0100, Kay Sievers wrote:
> That's all nonsense!
> 
>   $ udevinfo -r -q name -p /block/sr0
>   /dev/sr0

Ok, I couldn't find it for love or money.  But it's exactly what's
needed.

I see all the useful information is in /dev/.udev.tdb.  I need to have
a look at that TDB format, but exporting the database to other
programs works.

  OG.

