Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWGYRPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWGYRPs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 13:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWGYRPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 13:15:48 -0400
Received: from ns2.suse.de ([195.135.220.15]:39333 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750703AbWGYRPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 13:15:48 -0400
Date: Tue, 25 Jul 2006 10:10:55 -0700
From: Greg KH <gregkh@suse.de>
To: Edgar Hucek <hostmaster@ed-soft.at>
Cc: Michael Krufky <mkrufky@linuxtv.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Andrew de Quincey <adq_dvb@lidskialf.net>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 07/45] v4l/dvb: Fix CI on old KNC1 DVBC cards
Message-ID: <20060725171055.GB1846@suse.de>
References: <20060717160652.408007000@blue.kroah.org> <20060717162617.GH4829@kroah.com> <44C61616.7060203@ed-soft.at> <44C6358D.4040502@linuxtv.org> <44C63727.0@ed-soft.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C63727.0@ed-soft.at>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 05:22:15PM +0200, Edgar Hucek wrote:
> I don't own such a dvb card. I only saw it when trying to compile kernel 2.6.17.7.

Did that patch fix the build issue?

thanks,

greg k-h
