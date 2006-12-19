Return-Path: <linux-kernel-owner+w=401wt.eu-S932685AbWLSI4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbWLSI4S (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 03:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbWLSI4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 03:56:18 -0500
Received: from eazy.amigager.de ([213.239.192.238]:42187 "EHLO
	eazy.amigager.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932685AbWLSI4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 03:56:17 -0500
Date: Tue, 19 Dec 2006 09:56:16 +0100
From: Tino Keitel <tino.keitel@tikei.de>
To: linux-kernel@vger.kernel.org
Subject: Re: How to interpret PM_TRACE output
Message-ID: <20061219085616.GA2053@dose.home.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20061213212258.GA9879@dose.home.local> <20061216085748.GE4049@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061216085748.GE4049@ucw.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2006 at 08:57:48 +0000, Pavel Machek wrote:
> On Wed 13-12-06 22:22:59, Tino Keitel wrote:
> > Hi folks,
> > 
> > I tried PM_TRACE to find the driver that breaks resume from suspend.
> > I got working resume until I switched to the sk98lin driver
> > (because sky2 doesn't support wake on LAN). That's why I was quite sure that
> > sk98lin is the culprit, but I tried PM_TRACE anymay.
> 
> See Doc*/power/*.

There is a nice mixture of documentation about swusp, video stuff,
developer documentation, and one short paragraph about PM_TRACE that
tells me nothing new. Could you point me to the documentation part that
you are referring to, and that tells me what to do if PM_TRACE shows
the usb device but the failure only occurs when I load the sk98lin
driver?

Thanks and regards,
Tino
