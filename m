Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbUBYRq6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 12:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbUBYRos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 12:44:48 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:51348 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261487AbUBYRoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 12:44:08 -0500
Date: Wed, 25 Feb 2004 18:44:04 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Kyle Wong <kylewong@southa.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Any recommended PATA or SATA chip for kernel 2.6.x ?
Message-ID: <20040225174404.GA662@merlin.emma.line.org>
Mail-Followup-To: Kyle Wong <kylewong@southa.com>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <004c01c3fb66$b7ba9440$9c02a8c0@southa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004c01c3fb66$b7ba9440$9c02a8c0@southa.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Feb 2004, Kyle Wong wrote:

> I found in the market that most PCI IDE card are using "siimage (CMD?),
> HiPoint and IT8212 chip, are they working well with 2.6.x ?

http://kerneltrap.org/node/view/1787

http://www.freebsd.org/cgi/cvsweb.cgi/src/sys/dev/ata/ata-chipset.c?only_with_tag=MAIN#rev1.50

http://docs.freebsd.org/cgi/mid.cgi?402F88AB.8010003
http://docs.freebsd.org/cgi/mid.cgi?200311262104.hAQL4ICN024652
http://docs.freebsd.org/cgi/mid.cgi?40250AF7.3010804
http://docs.freebsd.org/cgi/mid.cgi?4022B5EF.4030807
http://docs.freebsd.org/cgi/mid.cgi?4023BF1C.6020008
