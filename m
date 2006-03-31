Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWCaUUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWCaUUF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 15:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWCaUUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 15:20:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1495 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751094AbWCaUUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 15:20:03 -0500
Date: Fri, 31 Mar 2006 15:19:59 -0500
From: Dave Jones <davej@redhat.com>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Non-Fatal Error PCI Express messages
Message-ID: <20060331201959.GI4133@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jurgen Kramer <gtm.kramer@inter.nl.net>,
	linux-kernel@vger.kernel.org
References: <1143793550.3331.4.camel@paragon.slim>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143793550.3331.4.camel@paragon.slim>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2006 at 10:25:50AM +0200, Jurgen Kramer wrote:
 > With 2.6.16 (from FC5s 2.6.16-1.2080_FC5smp) I am getting a lot of
 > 
 > Mar 31 09:35:16 paragon kernel: Non-Fatal Error PCI Express B
 > Mar 31 09:35:17 paragon kernel: Non-Fatal Error PCI Express B
 > Mar 31 09:35:17 paragon kernel: Non-Fatal Error PCI Express B
 > Mar 31 09:35:18 paragon kernel: Non-Fatal Error PCI Express B
 > Mar 31 09:35:18 paragon kernel: Non-Fatal Error PCI Express B
 > Mar 31 09:35:20 paragon kernel: Non-Fatal Error PCI Express B
 > Mar 31 09:35:20 paragon kernel: Non-Fatal Error PCI Express B
 > Mar 31 09:35:39 paragon kernel: Non-Fatal Error PCI Express B
 > 
 > messages which presumably come from
 > 
 > Mar 31 09:17:15 paragon kernel: MC: drivers/edac/edac_mc.c version
 > edac_mc  Ver: 2.0.0 Mar 28 2006
 > Mar 31 09:17:15 paragon kernel: EDAC MC0: Giving out device to
 > "e752x_edac" E7525: PCI 0000:00:00.0
 > 
 > Is there really something broken here of just a noisy driver?

really noisy driver.
http://lkml.org/lkml/2006/1/26/381

		Dave

-- 
http://www.codemonkey.org.uk
