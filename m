Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVANXDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVANXDS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 18:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVANXCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 18:02:54 -0500
Received: from orb.pobox.com ([207.8.226.5]:22958 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261416AbVANXAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 18:00:23 -0500
Date: Fri, 14 Jan 2005 15:00:01 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: David Jacoby <dj@outpost24.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux kernel 2.4.20-18.7smp bug
Message-ID: <20050114230001.GB4841@ip68-4-98-123.oc.oc.cox.net>
References: <200501140901.j0E91Lk07957@adf141.allyes.com> <1105695993.6080.25.camel@laptopd505.fenrus.org> <41E7E008.7040603@outpost24.com> <1105708214.6042.12.camel@laptopd505.fenrus.org> <41E7E308.2080504@outpost24.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E7E308.2080504@outpost24.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 04:19:36PM +0100, David Jacoby wrote:
> Well sorry for not making me clear, i forgot to say that
> im not using 2.4.20 or any other default kernel. Im using
> 2.6.10 from kernel.org.
> 
> the "vulnerability" im talking about is the following:
> 
> http://www.isec.pl/vulnerabilities/isec-0022-pagefault.txt

Try running a 2.6-ac kernel (the one that fixes this vulnerability is
2.6.10-ac9). The patch from 2.6.10 to 2.6.10-ac9 is linked on the
kernel.org web site. Here's the URL anyway:

http://kernel.org/pub/linux/kernel/people/alan/linux-2.6/2.6.10/patch-2.6.10-ac9.bz2

-Barry K. Nathan <barryn@pobox.com>

