Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751661AbWIOQP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbWIOQP7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 12:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbWIOQP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 12:15:59 -0400
Received: from nijmegen.renzel.net ([195.243.213.130]:35563 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S1751658AbWIOQP6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 12:15:58 -0400
From: Marcel Siegert <mws@linuxtv.org>
To: Michael Krufky <mkrufky@linuxtv.org>
Subject: Re: [patch 29/37] dvb-core: Proper handling ULE SNDU length of 0
Date: Fri, 15 Sep 2006 18:15:42 +0200
User-Agent: KMail/1.9.4
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Ang Way Chuang <wcang@nrg.cs.usm.my>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
References: <20060906224631.999046890@quad.kroah.org> <20060908172944.GA1254@suse.de> <450AD0CA.7080800@linuxtv.org>
In-Reply-To: <450AD0CA.7080800@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609151815.46517.mws@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 September 2006 18:11, Michael Krufky wrote:
> Greg KH wrote:
> > On Fri, Sep 08, 2006 at 08:58:49AM -0400, Michael Krufky wrote:
> >> Greg KH wrote:
> >>> -stable review patch.  If anyone has any objections, please let us know.
> >> Greg,
> >>
> >> Can we hold off on this until the 2.6.17.13 review cycle?  This patch
> >> has not been sent to the linux-dvb mailing list, it has not been
> >> reviewed or tested except for the Author and Marcel.
> > 
> > Yes, I've now moved it, thanks.
> 
> Marcel Siegert and I spoke about this today --  We are doing things a
> bit differently for 2.6.18 and later, but this patch is appropriate for
> 2.6.17.y
> 
> Please apply it for the next -stable kernel release.
> 
> Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
> 
> 
> 
Signed-off-by: Marcel Siegert <mws@linuxtv.org>

