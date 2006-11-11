Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947092AbWKKEbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947092AbWKKEbs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 23:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947091AbWKKEbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 23:31:48 -0500
Received: from 0x55511dab.adsl.cybercity.dk ([85.81.29.171]:36676 "EHLO
	hunin.borkware.net") by vger.kernel.org with ESMTP id S1947093AbWKKEbs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 23:31:48 -0500
Subject: Re: How to interpret MCE messages?
From: Mark Rosenstand <mark@borkware.net>
To: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
In-Reply-To: <200611090411.kA94BL5h006493@turing-police.cc.vt.edu>
References: <20061108162022.GA4258@piper.madduck.net>
	 <200611090411.kA94BL5h006493@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Sat, 11 Nov 2006 05:31:22 +0100
Message-Id: <1163219482.4093.7.camel@mjollnir.borkware.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 23:11 -0500, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 08 Nov 2006 17:20:22 +0100, martin f krafft said:
> 
> > The RAM modules are *not* ECC modules, nor does the Asus K8V Deluxe
> > motherboard support ECC to my knowledge. I've turned ECC support on
> > and off in the Bios without any effect.
> 
> How odd.  Is it considered normal to have a BIOS option to turn
> ECC support on/off on a motherboard that doesn't support ECC?

I think it does support ECC, at least that was my main argument to get a
K8V-X (less feature-bloated version, recommended by djb) two years ago,
as very few socket 754 boards supported it at that time (which is extra
weird since it comes pretty much for free with K8 CPU's.)

