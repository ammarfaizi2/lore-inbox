Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbVAABeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVAABeE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 20:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbVAABeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 20:34:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46865 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262172AbVAABeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 20:34:01 -0500
Date: Sat, 1 Jan 2005 01:33:57 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Jim Nelson <james4765@cwazy.co.uk>,
       Andrew Morton <akpm@osdl.org>, kernel-janitors@lists.osdl.org
Subject: Re: [KJ] Re: [PATCH] esp: Make driver SMP-correct
Message-ID: <20050101013357.A29907@flint.arm.linux.org.uk>
Mail-Followup-To: Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org, Jim Nelson <james4765@cwazy.co.uk>,
	Andrew Morton <akpm@osdl.org>, kernel-janitors@lists.osdl.org
References: <20041231014403.3309.58245.96163@localhost.localdomain> <200412311901.50638.gene.heskett@verizon.net> <20050101001311.D10216@flint.arm.linux.org.uk> <200412312014.39618.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200412312014.39618.gene.heskett@verizon.net>; from gene.heskett@verizon.net on Fri, Dec 31, 2004 at 08:14:39PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2004 at 08:14:39PM -0500, Gene Heskett wrote:
> On Friday 31 December 2004 19:13, Russell King wrote:
> >To: no To-header on input <>
> 
> Thats the To: line of this message Russell, as it came in here.  I 
> assume it was originally filled in to be to me and that you cleaned 
> that to prevent your getting a bounce from verizon?

Indeed, and I now have a better solution which I don't even have to
think about anymore, and doesn't damage the headers in the message. 8)

Let me know if and when verizon comes back to reality please.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
