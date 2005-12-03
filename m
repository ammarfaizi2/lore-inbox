Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbVLCWlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbVLCWlR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 17:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbVLCWlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 17:41:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:43981 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932163AbVLCWlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 17:41:16 -0500
X-Authenticated: #428038
Date: Sat, 3 Dec 2005 23:41:14 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051203224114.GE25722@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20051203135608.GJ31395@stusta.de> <1133620598.22170.14.camel@laptopd505.fenrus.org> <20051203152339.GK31395@stusta.de> <20051203162755.GA31405@merlin.emma.line.org> <4391CEC7.30905@unsolicited.net> <1133630012.6724.7.camel@localhost.localdomain> <4391D335.7040008@unsolicited.net> <20051203222138.GA25722@merlin.emma.line.org> <20051203222946.GB2863@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051203222946.GB2863@kroah.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 03 Dec 2005, Greg KH wrote:

> And if you use SUSE releases, use OpenSuSE to keep up to date with all
> of the needed kernel programs for the latest kernels.  Same with Fedora,
> Debian, or Gentoo.  They all keep up to date quite well.

Well, particular problem I've had: netfilter-enabled machines were
incapable to download large files, for instance newer ICC8 releases,
(major annoyance, their IIS crap doesn't support "Bytes" ranges, so you
start all over if one packet went down the wrong throat). I was told
"try newer kernels first", there had been fixes with out-of-window ACKs
and whatnot. I do not intend to upgrade all of my distro to the bleeding
OpenSUSE release just to find out if the new kernel fixes it and to see
new regressions. I have more interesting things to do with my time than
chase the userspace change of the day.

-- 
Matthias Andree
