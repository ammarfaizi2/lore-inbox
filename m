Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268785AbUHLVHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268785AbUHLVHU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268795AbUHLVHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:07:20 -0400
Received: from gprs214-76.eurotel.cz ([160.218.214.76]:39814 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268785AbUHLVCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:02:24 -0400
Date: Thu, 12 Aug 2004 23:02:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Eric Lammerts <eric@lammerts.org>
Cc: John M Collins <jmc@xisl.com>, linux-kernel@vger.kernel.org
Subject: Re: Program-invoking Symbolic Links?
Message-ID: <20040812210210.GA17113@elf.ucw.cz>
References: <200408051504.26203.jmc@xisl.com> <Pine.LNX.4.58.0408071208420.10018@vivaldi.madbase.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408071208420.10018@vivaldi.madbase.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > latest_version.tar => "tar cf - /latest/and/greatest"
> > latest_version.tgz => "gzip -c latest_version"

You can do that today with uservfs.(sf.net)
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
