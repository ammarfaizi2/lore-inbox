Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264279AbTDPJtn (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 05:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264280AbTDPJtn 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 05:49:43 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:5124 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S264279AbTDPJtm (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 05:49:42 -0400
Date: Wed, 16 Apr 2003 14:01:10 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: =?koi8-r?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DMA transfers in 2.5.67
Message-ID: <20030416140110.A642@jurassic.park.msu.ru>
References: <yw1x3ckjfs2v.fsf@zaphod.guide> <1050438684.28586.8.camel@dhcp22.swansea.linux.org.uk> <yw1xy92be915.fsf@zaphod.guide> <1050439715.28586.17.camel@dhcp22.swansea.linux.org.uk> <yw1xptnne7lv.fsf@zaphod.guide> <20030416123654.A2629@jurassic.park.msu.ru> <yw1xk7duessc.fsf@zaphod.guide> <yw1xadeqes1s.fsf@zaphod.guide> <yw1x65peeqm4.fsf@zaphod.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <yw1x65peeqm4.fsf@zaphod.guide>; from mru@users.sourceforge.net on Wed, Apr 16, 2003 at 11:30:43AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 11:30:43AM +0200, Måns Rullgård wrote:
> I set the latency to 128 using setpci and now I get 66 MB/s.  Other
> values give slower transfer rates.  Is there some other setting that
> could improve it even more?

Interesting. Did you set latency 128 for all devices or only for
3Dlabs card?

Ivan.
