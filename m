Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965093AbVKBPmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbVKBPmR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 10:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbVKBPmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 10:42:16 -0500
Received: from ns.sevcity.net ([193.47.166.213]:11709 "EHLO mail.sevcity.net")
	by vger.kernel.org with ESMTP id S965093AbVKBPmP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 10:42:15 -0500
Subject: Re: Would I be violating the GPL?
From: Alex Lyashkov <shadow@psoft.net>
To: Nix <nix@esperi.org.uk>
Cc: Giuliano Pochini <pochini@shiny.it>, alex@alexfisher.me.uk,
       linux-kernel@vger.kernel.org, "Jeff V. Merkey" <jmerkey@utah-nac.org>,
       Michael Buesch <mbuesch@freenet.de>
In-Reply-To: <87fyqfm5jx.fsf@amaterasu.srvr.nix>
References: <XFMail.20051102104916.pochini@shiny.it>
	 <1130943242.3367.39.camel@berloga.shadowland>
	 <87fyqfm5jx.fsf@amaterasu.srvr.nix>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8BIT
Organization: Positive Software
Message-Id: <1130946128.3367.50.camel@berloga.shadowland>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-16) 
Date: Wed, 02 Nov 2005 17:42:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

В Срд, 02.11.2005, в 17:29, Nix пишет:
> On 2 Nov 2005, Alex Lyashkov moaned:
> >> > So despite the fact the driver has been written in c++, it
> >> > might be possible to write a usable specification.
> >> 
> >> Linux 2.6 doesn't accept c++, so you have to rewrite it anyway.
> >> You should ask them if you can publish your own driver based
> >> on infos you extract from their driver.
> >> 
> > without exeption c++ code can be used at drivers.
> 
> The rather important `struct class' may give you trouble there.
Long time ago (over 4 years ago) i work with poring VPN and firewall
NDIS driver from Win32 to Linux. Only small kernel interface was writeln
at pure C, all other at C++. How i remember need only create operator
new and delete, also don`t use [out|in]stream. 


-- 
FreeVPS Developers Team  http://www.freevps.com
Positive Software        http://www.psoft.net

