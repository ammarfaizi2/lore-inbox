Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318607AbSGaXqB>; Wed, 31 Jul 2002 19:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318614AbSGaXqB>; Wed, 31 Jul 2002 19:46:01 -0400
Received: from ns.suse.de ([213.95.15.193]:15886 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318607AbSGaXqB>;
	Wed, 31 Jul 2002 19:46:01 -0400
Date: Thu, 1 Aug 2002 01:49:25 +0200
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       David Luyer <david_luyer@pacific.net.au>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19ac3rc3 on IBM x330/x340 SMP - "ps" time skew
Message-ID: <20020801014925.L10436@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	David Luyer <david_luyer@pacific.net.au>,
	linux-kernel@vger.kernel.org
References: <200207311914.g6VJEG5308283@saturn.cs.uml.edu> <1028162237.13008.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1028162237.13008.26.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Aug 01, 2002 at 01:37:17AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 01:37:17AM +0100, Alan Cox wrote:
 > > Add a proper ABI now, and userspace can transition to it
 > > over the next 4 years.
 > 
 > Which is what I've been talking to Ulrich about.

I thought this was the idea behind sysconf(__SC_NPROCESSORS_CONF) ?

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
