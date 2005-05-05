Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbVEEM5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbVEEM5m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 08:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbVEEM5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 08:57:42 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:58601 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262090AbVEEM5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 08:57:40 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm3
Date: Thu, 5 May 2005 14:58:08 +0200
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
References: <20050504221057.1e02a402.akpm@osdl.org>
In-Reply-To: <20050504221057.1e02a402.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505051458.08659.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 5 of May 2005 07:10, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm3/
> 
> - device mapper updates
> 
> - more UML updates
> 
> - -mm seems unusually stable at present.

Well, it does not boot on my box (Athlon64 + NForce3, 64-bit).  Apparently, it
loops forever in the early stage (ie before displaying the pengiun).  I'll try
to get more information when I find something to attach to the serial port ...

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
