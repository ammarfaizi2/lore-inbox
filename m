Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262167AbVAAANT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbVAAANT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 19:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbVAAANS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 19:13:18 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16913 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262167AbVAAANP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 19:13:15 -0500
Date: Sat, 1 Jan 2005 00:13:11 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Jim Nelson <james4765@cwazy.co.uk>,
       Andrew Morton <akpm@osdl.org>, kernel-janitors@lists.osdl.org
Subject: Re: [KJ] Re: [PATCH] esp: Make driver SMP-correct
Message-ID: <20050101001311.D10216@flint.arm.linux.org.uk>
References: <20041231014403.3309.58245.96163@localhost.localdomain> <20041231170139.B10216@flint.arm.linux.org.uk> <41D5CFCA.7000300@cwazy.co.uk> <200412311901.50638.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200412311901.50638.gene.heskett@verizon.net>; from gene.heskett@verizon.net on Fri, Dec 31, 2004 at 07:01:50PM -0500
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2004 at 07:01:50PM -0500, Gene Heskett wrote:
> One should be carefull as that shoe can fit many feet. The CC: line of 
> this message:
> 
> Jim Nelson <james4765@cwazy.co.uk>, Russell King 
> <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>, 
> kernel-janitors@lists.osdl.org
> 
> I'm curious as to who I will get a bounce from.

Well, you'll get one from me, but not because _I've_ blocked verizon (I've
done no such thing.)  Since I'm unable to verify verizon's addresses, all
mail from verizon is unable to be received here anymore.

(and yes, you get to read my reply via lkml...)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
