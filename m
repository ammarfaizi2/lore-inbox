Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbTD3ALg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 20:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbTD3ALg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 20:11:36 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:58055 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262041AbTD3ALf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 20:11:35 -0400
Date: Wed, 30 Apr 2003 01:22:55 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Gabriel Devenyi <devenyga@mcmaster.ca>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KernelJanitor: Convert remaining error returns to return -E Linux 2.5.68
Message-ID: <20030430002240.GA29365@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Gabriel Devenyi <devenyga@mcmaster.ca>,
	"Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
References: <200304292215.20590.devenyga@mcmaster.ca> <20030429153244.19c32b3c.rddunlap@osdl.org> <200304292308.30947.devenyga@mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304292308.30947.devenyga@mcmaster.ca>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 29, 2003 at 11:08:30PM +0000, Gabriel Devenyi wrote:

 > P.S. Anyone who works on KernelJanitor, kj.pl is suggesting some of the things 
 > I'm changing which aparently I shouldn't.

I'd take most things it says with a pinch of salt.
I wasn't kidding when I said I knew no perl at all before I wrote this.
I stopped hacking on it when Dan Carpenters smatch appeared, as it
was a more 'real' solution with a future.

kj.pl was a fun weekend hack.

		Dave

