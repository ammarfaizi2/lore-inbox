Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTGKOc3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 10:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbTGKOc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 10:32:29 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:63677 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262499AbTGKOc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 10:32:29 -0400
Date: Fri, 11 Jul 2003 16:46:17 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030711144617.GK10217@louise.pinerecords.com>
References: <20030711140219.GB16433@suse.de> <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > - gcc 3.2.2-5 as shipped by Red Hat generates incorrect code in the
> >   kmalloc optimisation introduced in 2.5.71
> >   See http://linus.bkbits.net:8080/linux-2.5/cset@1.1410
> 
> This URL appears wrong!

Nahh, that's just the same old annoying bkbits bug.  Try with lynx...

-- 
Tomas Szepe <szepe@pinerecords.com>
