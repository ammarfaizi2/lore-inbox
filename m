Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbWIHRan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWIHRan (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 13:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWIHRan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 13:30:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:2994 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750909AbWIHRam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 13:30:42 -0400
Date: Fri, 8 Sep 2006 10:29:44 -0700
From: Greg KH <gregkh@suse.de>
To: Michael Krufky <mkrufky@linuxtv.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Ang Way Chuang <wcang@nrg.cs.usm.my>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
Subject: Re: [patch 29/37] dvb-core: Proper handling ULE SNDU length of 0
Message-ID: <20060908172944.GA1254@suse.de>
References: <20060906224631.999046890@quad.kroah.org> <20060906225740.GD15922@kroah.com> <45016909.4080908@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45016909.4080908@linuxtv.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 08:58:49AM -0400, Michael Krufky wrote:
> Greg KH wrote:
> > -stable review patch.  If anyone has any objections, please let us know.
> 
> Greg,
> 
> Can we hold off on this until the 2.6.17.13 review cycle?  This patch
> has not been sent to the linux-dvb mailing list, it has not been
> reviewed or tested except for the Author and Marcel.

Yes, I've now moved it, thanks.

> Please also add me to the cc list for the stable patches review.

Now added, thanks.

greg k-h
