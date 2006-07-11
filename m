Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWGKWW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWGKWW2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWGKWW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:22:28 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:47003 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932208AbWGKWW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:22:27 -0400
Date: Tue, 11 Jul 2006 23:22:02 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alon Bar-Lev <alon.barlev@gmail.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       "John W. Linville" <linville@tuxdriver.com>, joesmidt@byu.net,
       linux-kernel@vger.kernel.org
Subject: Re: Will there be Intel Wireless 3945ABG support?
Message-ID: <20060711222202.GA5064@srcf.ucam.org>
References: <1152635563.4f13f77cjsmidt@byu.edu> <20060711171238.GA26186@tuxdriver.com> <200607111909.22972.s0348365@sms.ed.ac.uk> <44B3ED29.4040801@gmail.com> <1152644119.18028.46.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152644119.18028.46.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 07:55:19PM +0100, Alan Cox wrote:

> Hopefully Intel will find a sensible solution to the problem or someone
> will just reverse engineer it away.

The ipw3945_daemon.h file includes a pretty full description of what the 
daemon has to do, and all the structures have nice friendly names. 
There's also a changelog of the protocol. It shouldn't take someone 
long.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
