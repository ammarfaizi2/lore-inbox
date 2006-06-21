Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWFUSmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWFUSmX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 14:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWFUSmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 14:42:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58341 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932306AbWFUSmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 14:42:21 -0400
Date: Wed, 21 Jun 2006 14:42:04 -0400
From: Dave Jones <davej@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc6-mm1
Message-ID: <20060621184204.GD26046@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060607104724.c5d3d730.akpm@osdl.org> <20060608050047.GB16729@redhat.com> <1150825349.2891.219.camel@laptopd505.fenrus.org> <20060621062346.GA10637@redhat.com> <1150877733.3057.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150877733.3057.15.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 10:15:33AM +0200, Arjan van de Ven wrote:

 > >  > Does this fix it for you? (it fixes the case for me)
 > > 
 > > Hmm. This makes things drastically worse for me. Now it hangs during NFS startup.
 > 
 > hmm that's highly unexpected

It did the same thing with your diff backed out.
I think my testbox needs a reinstall.
Probably won't happen for a few days though.

		Dave

-- 
http://www.codemonkey.org.uk
