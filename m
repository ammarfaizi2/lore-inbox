Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263572AbTE3KpK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 06:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTE3KpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 06:45:10 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:35539 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263572AbTE3KpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 06:45:09 -0400
Date: Fri, 30 May 2003 12:00:56 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: William McDonald Buck <dee@wmbuck.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: More info on non-booting 2.5.69/2.5.70
Message-ID: <20030530110056.GA16326@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	William McDonald Buck <dee@wmbuck.net>,
	linux-kernel@vger.kernel.org
References: <OJEPIBLILBCOMMNBMCLLMEBGCFAA.dee@wmbuck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OJEPIBLILBCOMMNBMCLLMEBGCFAA.dee@wmbuck.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28, 2003 at 08:59:53AM -0400, William McDonald Buck wrote:
 > I'm not subscribed, but read everything I could find here on
 > non-booting 2.5 kernels, and with help from list archives found and
 > fixed my problems.  Had the problem others have reported -- hang
 > after unpacking the kernel, blank screen.  Advice given here, and in
 > "what to expect" document is to ensure one has set CONFIG_INPUT=y,
 > CONFIG_VT=Y and CONFIG_VT_CONSOLE=Y (and sometimes says to set
 > CONFIG_HW_CONSOLE=y). The advice does not say -- and I think should
 > and must -- to set CONFIG_VGA_CONSOLE=y.

The work-in-progress version of the next version of that document
already documents this (and a few other things that may cause this
effect). I'll look at getting it updated in the next few days

		Dave

