Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751688AbWIOQid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbWIOQid (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 12:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbWIOQid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 12:38:33 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:15007 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751687AbWIOQid
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 12:38:33 -0400
Subject: Re: [patch 29/37] dvb-core: Proper handling ULE SNDU length of 0
From: Marcel Holtmann <marcel@holtmann.org>
To: Michael Krufky <mkrufky@linuxtv.org>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Ang Way Chuang <wcang@nrg.cs.usm.my>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Marcel Siegert <mws@linuxtv.org>
In-Reply-To: <450AD0CA.7080800@linuxtv.org>
References: <20060906224631.999046890@quad.kroah.org>
	 <20060906225740.GD15922@kroah.com> <45016909.4080908@linuxtv.org>
	 <20060908172944.GA1254@suse.de>  <450AD0CA.7080800@linuxtv.org>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 18:36:01 +0200
Message-Id: <1158338161.5233.47.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

> >> Can we hold off on this until the 2.6.17.13 review cycle?  This patch
> >> has not been sent to the linux-dvb mailing list, it has not been
> >> reviewed or tested except for the Author and Marcel.
> > 
> > Yes, I've now moved it, thanks.
> 
> Marcel Siegert and I spoke about this today --  We are doing things a
> bit differently for 2.6.18 and later, but this patch is appropriate for
> 2.6.17.y

so this means it is fixed in 2.6.18 or is it still vulnerable. If it is
still vulnerable, then we need a fix. And we need it now.

Regards

Marcel


