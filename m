Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVFYMhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVFYMhN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 08:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVFYMhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 08:37:13 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:56006 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261212AbVFYMfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 08:35:10 -0400
Date: Sat, 25 Jun 2005 14:34:35 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: linux-kernel@vger.kernel.org, Stuart Shelton <stuart@zeus.com>,
       Daniel Drake <dsd@gentoo.org>, Alan Lake <alan.lake@lakeinfoworks.com>,
       petero2@telia.co.uk, vojtech@suse.cz
Subject: Re: ALPS touchpad issues still exist in 2.6.12-rc4h
In-Reply-To: <200505102059.36744.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.61.0506251431340.3743@scrub.home>
References: <42801AEE.5080308@lakeinfoworks.com> <d120d5000505101520ad1761@mail.gmail.com>
 <1115767038.12779.36.camel@callisto.dnsalias.net> <200505102059.36744.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 10 May 2005, Dmitry Torokhov wrote:

> > More than this, with every kernel (at least since the very early 2.4
> > ones) up to 2.6.10 the ALPS touchpad has worked just fine through
> > input/mice or the psaux device - why has this changed in 2.6.11,
> 
> Because some people do not want tapping and some people do not like
> default sensitivity and some like having virtual scrolling while other
> want to have different actions assigned to corner taps.

I skipped 2.6.11 on my laptop, so I'm only noticing this problem now.
You didn't really answer the question, why has the _default_ been changed, 
giving users the possibility to change the defaults is fine, but why is it 
necessary to break existing setups?

bye, Roman
