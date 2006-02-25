Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWBYKxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWBYKxo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 05:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbWBYKxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 05:53:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:2447 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030203AbWBYKxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 05:53:43 -0500
Date: Sat, 25 Feb 2006 10:53:40 +0000
From: Christoph Hellwig <hch@infradead.org>
To: gene.heskett@verizononline.net
Cc: James Ketrenos <jketreno@linux.intel.com>, NetDev <netdev@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [Announce] Intel PRO/Wireless 3945ABG Network Connection
Message-ID: <20060225105340.GA23643@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	gene.heskett@verizononline.net,
	James Ketrenos <jketreno@linux.intel.com>,
	NetDev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <43FF88E6.6020603@linux.intel.com> <20060225084139.GB22109@infradead.org> <200602250549.47547.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602250549.47547.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 05:49:47AM -0500, Gene Heskett wrote:
> As someone (a broadcast engineer with 40+ years of carrying what used to 
> be a 1st phone) obviously more familiar with the FCC R&R than you 
> apparently are, Christoph, I'll have to argue that point.

Please stop spreading the bullshit.  Please quote the FCC regulation on
this.

> So basicly, you can accept it with the wrappers Intel provides, or linux 
> will not have access to the use of these devices, any of them that fit 
> in the category of "software radios".

We have support for other software radios.  If intel doesn't do the right
thing support for their hardware will have to wait until someone has
reverse-engineered their daemon [1].

[1] they disallow it in their license, but that's completely void in many
    countries.
