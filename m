Return-Path: <linux-kernel-owner+w=401wt.eu-S965045AbWL2IxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbWL2IxQ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 03:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbWL2IxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 03:53:16 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:39152 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965031AbWL2IxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 03:53:15 -0500
Date: Fri, 29 Dec 2006 11:48:37 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ingo Molnar <mingo@elte.hu>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Jamal Hadi Salim <hadi@cyberus.ca>
Subject: Re: [take29 0/8] kevent: Generic event handling mechanism.
Message-ID: <20061229084837.GA13816@2ka.mipt.ru>
References: <3154985aa0591036@2ka.mipt.ru> <11668927001365@2ka.mipt.ru> <20061228155645.GA7516@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061228155645.GA7516@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 04:56:45PM +0100, Ingo Molnar (mingo@elte.hu) wrote:
> 
> * Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> 
> > Generic event handling mechanism.
> 
> it would be /very/ helpful to state against which kernel tree the 
> patch-queue is. It does not apply to 2.6.20-rc1 nor to -rc2 nor to 
> 2.6.19. At which point i gave up ...

It was against 2.6.18 (d4397acde6fd047f13c744e5471a9bfe287f78a3) git.
Next patchset with possibility to inject already read event and
userspace reserved notifications will be against the latest tree (I will
push it today before final New Year celebration started).

> 	Ingo

-- 
	Evgeniy Polyakov
