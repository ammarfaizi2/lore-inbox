Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbWBDSXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbWBDSXA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 13:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbWBDSXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 13:23:00 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28935 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932543AbWBDSW7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 13:22:59 -0500
Date: Fri, 3 Feb 2006 22:50:50 +0000
From: Pavel Machek <pavel@suse.cz>
To: s.schmidt@avm.de
Cc: linux-kernel@vger.kernel.org, opensuse-factory@opensuse.org, kkeil@suse.de
Subject: Re: 2.6.16 serious consequences / GPL_EXPORT_SYMBOL / USB drivers of major vendor excluded
Message-ID: <20060203225049.GA2420@ucw.cz>
References: <200601200904.00389.dazzle.digital@gmail.com> <OF7A130C3D.76EBAB24-ONC125710A.003AC847-C125710A.005A1B7D@avm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OF7A130C3D.76EBAB24-ONC125710A.003AC847-C125710A.005A1B7D@avm.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> consequences
> Because of the GPL_EXPORT declaration it is no longer possible to build and
> run non-GPL loadable drivers for USB devices. We´ve put a lot of energy
> into providing the open source community with Linux drivers for nearly all

Last time I checked, it was easy to write usb drivers in userspace.

							Pavel
-- 
Thanks, Sharp!
