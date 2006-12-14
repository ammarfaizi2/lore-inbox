Return-Path: <linux-kernel-owner+w=401wt.eu-S1750994AbWLNRIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWLNRIq (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 12:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWLNRIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 12:08:46 -0500
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:23434 "HELO
	smtp114.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750973AbWLNRIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 12:08:45 -0500
X-YMail-OSG: o8itzcYVM1kbKS2TD7NEcXPld.VpQlaLVIzAuExZD3ZsJhmuY.V8feeTvce6QGq_Ky7UbtlWkSP4Cfw6b8qOYFqhwDmUspFrP0pAVHDrTJ9XHtciOSCxmg--
Date: Thu, 14 Dec 2006 09:08:41 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, Greg KH <gregkh@suse.de>,
       Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061214170841.GA11196@tuatara.stupidest.org>
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net> <20061214005532.GA12790@suse.de> <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org> <458171C1.3070400@garzik.org> <Pine.LNX.4.64.0612140855250.5718@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612140855250.5718@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 09:03:57AM -0800, Linus Torvalds wrote:

> I actually think the EXPORT_SYMBOL_GPL() thing is a good thing, if
> done properly (and I think we use it fairly well).
>
> I think we _can_ do things where we give clear hints to people that
> "we think this is such an internal Linux thing that you simply
> cannot use this without being considered a derived work".

Then why not change the name to something more along those lines?
