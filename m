Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267464AbUJTVKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267464AbUJTVKE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 17:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270553AbUJTVFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 17:05:22 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:32731 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S270543AbUJTVAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 17:00:02 -0400
Subject: Re: forcing PS/2 USB emulation off
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Greg KH <greg@kroah.com>, Dmitry Torokhov <dtor_core@ameritech.net>,
       Alexandre Oliva <aoliva@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041019063057.GA3057@ucw.cz>
References: <orzn2lyw8k.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <200410172248.16571.dtor_core@ameritech.net>
	 <20041018164539.GC18169@kroah.com>  <20041019063057.GA3057@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098302200.12374.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 20 Oct 2004 20:56:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-10-19 at 07:30, Vojtech Pavlik wrote:
> Like 30% of all notebooks? ;) They do boot without the USB handoff, the
> PS/2 mouse works, but only as a PS/2 mouse, no extended capabilities
> detection is possible due to the BIOS interference.

I started in favour of avoiding always doing the handoff, but now I'm
convinced handoff should be the default. 

Alan

