Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266941AbUBEXG5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 18:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267091AbUBEXEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 18:04:02 -0500
Received: from ms-smtp-01.rdc-kc.rr.com ([24.94.166.115]:62443 "EHLO
	ms-smtp-01.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S267087AbUBEXDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 18:03:19 -0500
Date: Thu, 5 Feb 2004 17:03:04 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-users@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: usb mouse/keyboard problems under 2.6.2
Message-ID: <20040205230304.GA2195@yggdrasil.localdomain>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-usb-users@lists.sourceforge.net,
	linux-usb-devel@lists.sourceforge.net
References: <20040204174748.GA27554@yggdrasil.localdomain> <20040205142155.GA606@ucw.cz> <20040205160226.GA13471@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205160226.GA13471@yggdrasil.localdomain>
X-Operating-System: Linux yggdrasil 2.6.2 #1 SMP Thu Feb 5 16:01:48 CST 2004 i686 GNU/Linux
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the output from dmesg, after rebuilding with CONFIG_USB_DEBUG
enabled.  It doesn't seem to be producing any output from after the
initialization completed (and the problem has recurred several times
since then), so please let me know if I should be going about this
differently.

Thanx!
