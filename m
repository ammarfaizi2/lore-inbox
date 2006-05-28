Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWE1HVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWE1HVz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 03:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWE1HVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 03:21:55 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18950 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932066AbWE1HVy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 03:21:54 -0400
Date: Sun, 28 May 2006 07:21:40 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jens Gtze <jens.goetze@1in1.de>
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux and Wireless USB Adaptor
Message-ID: <20060528072140.GB4108@ucw.cz>
References: <44793F44.1040603@perkel.com> <447946F8.9090407@1in1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447946F8.9090407@1in1.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 28-05-06 08:45:12, Jens G?tze wrote:
> Hello Marc,
> 
> I would try ndiswrapper (http://ndiswrapper.sf.net), because it is the
> easiest way to run a USB Wireless LAN adapter. The ndiswrapper is a nice
> driver, which allows to run Windows NDIS Driver under Linux. Therefore,

For some very obscure definition of 'nice'...  

Avoid ndiswrapper, it is broken by design.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
