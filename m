Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263719AbUDQIuk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 04:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbUDQIuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 04:50:40 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:56226 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S263719AbUDQIuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 04:50:39 -0400
Date: Sat, 17 Apr 2004 08:50:37 +0000
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: parallel port i2c adapter schematics
Message-ID: <20040417085037.B7667@beton.cybernet.src>
References: <20040416163434.GA9704@atrey.karlin.mff.cuni.cz> <20040416121816.6f958b29.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040416121816.6f958b29.rddunlap@osdl.org>; from rddunlap@osdl.org on Fri, Apr 16, 2004 at 12:18:16PM -0700
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 12:18:16PM -0700, Randy.Dunlap wrote:
> On Fri, 16 Apr 2004 18:34:34 +0200 Karel Kulhavy wrote:
> 
> | Hello
> | 
> | There are 3 various parallel port i2c adapters in 2.6.3 kernel and only
> | one *.txt in Documentation/. Where can I get the schematics for these
> | adapters? In make menuconfig < Help > there is also nothing.
> 
> Do you mean 'schematic' as in:
> "noun:  diagram of an electrical or mechanical system"
> ?  or something else?

Yes how to hook up the transistors or what between SDA/SCL and parport.

Or just the information which pin which signal goes and which polarity.
I can design the rest myself, no problem.

For example: SDA goes to SLCTIN wich such polarity...

Cl<

