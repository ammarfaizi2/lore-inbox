Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVDDHP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVDDHP2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 03:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVDDHP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 03:15:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45250 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261583AbVDDHPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 03:15:25 -0400
Date: Mon, 4 Apr 2005 08:15:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Paul Jackson <pj@engr.sgi.com>
Cc: Mark Lord <lkml@rtr.ca>, zlynx@acm.org, greg@kroah.com, floam@sh.nu,
       mrmacman_g4@mac.com, linux-kernel@vger.kernel.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Message-ID: <20050404071513.GA4754@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paul Jackson <pj@engr.sgi.com>, Mark Lord <lkml@rtr.ca>,
	zlynx@acm.org, greg@kroah.com, floam@sh.nu, mrmacman_g4@mac.com,
	linux-kernel@vger.kernel.org
References: <1111886147.1495.3.camel@localhost> <490243b66dc7c3f592df7a7d0769dcb7@mac.com> <20050327181221.GB14502@kroah.com> <1112058277.14563.4.camel@localhost> <20050329033350.GA6990@kroah.com> <1112069010.12853.52.camel@localhost> <42507F2F.1050405@rtr.ca> <20050403210145.0d1c1eff.pj@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050403210145.0d1c1eff.pj@engr.sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2005 at 09:01:45PM -0700, Paul Jackson wrote:
> Mark wrote:
> > Probably all Linux binary drivers *are* compiled using GPL'd header files,
> > and thus are themselves subject to the GPL.
> 
> I doubt that there is a consensus that simply compiling something with
> a GPL header necessarily and always subjects it to the GPL.  See your lawyer.

For a header as in interface maybe not.  For headers containing significant
code in inline functions the binary drivers is definitly a derived work.

