Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbTJaP2L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 10:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbTJaP2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 10:28:11 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:61324 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S263364AbTJaP2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 10:28:08 -0500
Date: Fri, 31 Oct 2003 16:26:50 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Jakob Oestergaard <jakob@unthought.net>
cc: Maciej Zenczykowski <maze@cela.pl>, Dave Brondsema <dave@brondsema.net>,
       linux-kernel@vger.kernel.org
Subject: Re: uptime reset after about 45 days
In-Reply-To: <20031031103723.GE10792@unthought.net>
Message-ID: <Pine.LNX.4.53.0310311621010.794@gockel.physik3.uni-rostock.de>
References: <1067552357.3fa18e65d1fca@secure.solidusdesign.com>
 <Pine.LNX.4.44.0310310005090.11473-100000@gaia.cela.pl>
 <20031031103723.GE10792@unthought.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Oct 2003, Jakob Oestergaard wrote:

> Still, it's pretty darn pathetic to be required to include workarounds
> in *Linux* apps that would otherwise only be needed for '95.

There's nothing wrong with Linux here, it works out of the box.
If you choose to patch with an inappropriate set of patches, it breaks.

So either apply
  http://www.physik3.uni-rostock.de/tim/kernel/2.4/jiffies64-21.patch.gz
as well, or don't patch at all.

Just my two cents.

Tim
