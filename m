Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbTLUMoR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 07:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbTLUMoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 07:44:17 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:50612 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262817AbTLUMoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 07:44:16 -0500
Date: Sun, 21 Dec 2003 13:44:13 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Fw: 2.6.0-test11 BK: sg and scanner modules not auto-loaded?
Message-ID: <20031221124413.GA22924@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20031219181039.GI3017@kroah.com> <20031221003020.63E6A2C0B8@lists.samba.org> <20031221012531.GB30123@merlin.emma.line.org> <200312211337.30900.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312211337.30900.baldrick@free.fr>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Dec 2003, Duncan Sands wrote:

> I haven't been following this thread, so I don't know if this is relevant:
> do you have the *very latest* hotplug scripts?  The previous ones tested
> the kernel version against "2.5", while the latest test against that and also
> "2.6".  I think this was in the usb script.  Without the "2.6" test device
> scripts are not run, at least for usb devices.

You bet SuSE Linux 8.2 isn't 2.6 ready (I wonder if 9.0 ships with
current hotplug), so I'll have to update my hotplug.  Thanks for the
pointer.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
