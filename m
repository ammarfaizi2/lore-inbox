Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbTJNNCj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 09:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbTJNNCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 09:02:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18957 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262534AbTJNNCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 09:02:38 -0400
Date: Tue, 14 Oct 2003 14:02:22 +0100
From: Dave Jones <davej@redhat.com>
To: John Madden <weez@freelists.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: agpgart and SiS 5591/5592 - ever?
Message-ID: <20031014130222.GA11453@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	John Madden <weez@freelists.org>, linux-kernel@vger.kernel.org
References: <200310132234.45163.weez@freelists.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310132234.45163.weez@freelists.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 13, 2003 at 10:34:45PM -0500, John Madden wrote:
 > I seem to be unfortunate enough to be the owner of a motherboard with an 
 > SiS 5591/5592 AGP chipset.  It seems to be a common-enough chipset that 
 > there would be a driver for it by now (checked 2.4.23-pre and 2.6.0-test7) 
 > -- bad vendor?

No specs + no hardware = no support. For someone with both, it's
possibly not much work to bend one of the existing drivers to fit.

 > Am I SoL here?  Time to get another motherboard?  I'd be happy to lend my 
 > hardware to testing.

You're SoL for now at least. See if you can chase up a contact at SiS.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
