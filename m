Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWHHKHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWHHKHy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 06:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWHHKHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 06:07:54 -0400
Received: from tango.0pointer.de ([217.160.223.3]:59153 "EHLO
	tango.0pointer.de") by vger.kernel.org with ESMTP id S964783AbWHHKHw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 06:07:52 -0400
Date: Tue, 8 Aug 2006 12:07:46 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: A few new KEY_xxx definitions
Message-ID: <20060808100744.GA16201@tango.0pointer.de>
References: <20060808000925.GA6220@curacao> <200608072219.02315.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608072219.02315.dtor@insightbb.com>
Organization: .phi.
X-Campaign-1: ()  ASCII Ribbon Campaign
X-Campaign-2: /  Against HTML Email & vCards - Against Microsoft Attachments
X-Disclaimer-1: Diese Nachricht wurde mit einer elektronischen 
X-Disclaimer-2: Datenverarbeitungsanlage erstellt und bedarf daher 
X-Disclaimer-3: keiner Unterschrift.
User-Agent: Leviathan/19.8.0 [zh] (Cray 3; I; Solaris 4.711; Console)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07.08.06 22:19, Dmitry Torokhov (dtor@insightbb.com) wrote:

> > KEY_POWERPLUG, KEY_POWERUNPLUG:
> > 
> >     Some laptops generate a fake key event when the power cord is
> >     plugged or unplugged. (Notably MSI laptops, such as S270)
> > 
> 
> How do these events get delivered? Are you saying that atkbd reports
> key presses when pulling out AC cord?

Yes, exactly.

Lennart
