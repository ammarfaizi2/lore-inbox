Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbVCBPe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVCBPe0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 10:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbVCBPe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 10:34:26 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:21453 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262313AbVCBPeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 10:34:22 -0500
Date: Wed, 2 Mar 2005 07:30:45 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: guillaume.thouvenin@bull.net, kaigai@ak.jp.nec.com, johnpol@2ka.mipt.ru,
       hadi@cyberus.ca, tgraf@suug.ch, marcelo.tosatti@cyclades.com,
       davem@redhat.com, jlan@sgi.com, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       elsa-devel@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
Message-Id: <20050302073045.4dfefa11.pj@sgi.com>
In-Reply-To: <20050302010614.2a8bb483.akpm@osdl.org>
References: <4221E548.4000008@ak.jp.nec.com>
	<20050227140355.GA23055@logos.cnet>
	<42227AEA.6050002@ak.jp.nec.com>
	<1109575236.8549.14.camel@frecb000711.frec.bull.fr>
	<20050227233943.6cb89226.akpm@osdl.org>
	<1109592658.2188.924.camel@jzny.localdomain>
	<20050228132051.GO31837@postel.suug.ch>
	<1109598010.2188.994.camel@jzny.localdomain>
	<20050228135307.GP31837@postel.suug.ch>
	<1109599803.2188.1014.camel@jzny.localdomain>
	<20050228142551.GQ31837@postel.suug.ch>
	<1109604693.1072.8.camel@jzny.localdomain>
	<20050228191759.6f7b656e@zanzibar.2ka.mipt.ru>
	<1109665299.8594.55.camel@frecb000711.frec.bull.fr>
	<42247051.7070303@ak.jp.nec.com>
	<1109753893.8422.127.camel@frecb000711.frec.bull.fr>
	<20050302010614.2a8bb483.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> 5-10% slowdown on fork is expected, but
> why was exec slower?

Thanks for the summary, Andrew.

Guillaume (or anyone else tempted to do this) - it's a good idea, when
posting 100 lines of data, to summarize with a line or two of words, as
Andrew did here.  It is far more efficient for one writer to do this,
than each of a thousand readers.

Hmmm ... so why was exec slower?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
