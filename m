Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbVBQK23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbVBQK23 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 05:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVBQK23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 05:28:29 -0500
Received: from gate.firmix.at ([80.109.18.208]:21635 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S262183AbVBQK2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 05:28:25 -0500
Subject: Re: Bug in SLES8 kernel 2.4.x freezing HP DL740/760
From: Bernd Petrovitsch <bernd@firmix.at>
To: Oliver Antwerpen <olli@giesskaennchen.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4213B519.7040202@giesskaennchen.de>
References: <4213AB2B.2050604@giesskaennchen.de>
	 <4213B1FC.4020706@tiscali.de>  <4213B519.7040202@giesskaennchen.de>
Content-Type: text/plain
Organization: Firmix Software GmbH
Message-Id: <1108636102.15172.2.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Thu, 17 Feb 2005 11:28:23 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-16 at 22:03 +0100, Oliver Antwerpen wrote:
> Matthias-Christian Ott schrieb:
> > Oliver Antwerpen wrote:
> >> SuSE has patched UNICON into the kernel which will cause these servers 
> >> to hang when booted with vga=normal. The system will run fine in 
> >> fb-mode, but not in plain text.
> >
> > Well if you don't need unicon, then remove the patch from the .spec file 
> > and rebuild the kernel (from the source rpm). Or report it their bug 
> > tracking system.
> 
> My problem ist, that when I change .config, then I lose my support. So
> SuSE or HP have to tell me to do so.

And they listen here to you?

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

