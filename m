Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbTJGXrk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 19:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbTJGXrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 19:47:40 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:13950 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263079AbTJGXri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 19:47:38 -0400
Date: Wed, 8 Oct 2003 00:46:55 +0100
From: Dave Jones <davej@redhat.com>
To: Len Brown <len.brown@intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Dimitri Torfs <dimitri@sonycom.com>, acpi-devel@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: vaio doesn't poweroff with 2.4.22 (fwd)
Message-ID: <20031007234655.GA10471@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Len Brown <len.brown@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Dimitri Torfs <dimitri@sonycom.com>,
	acpi-devel@lists.sourceforge.net,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.21.0310022254280.8802-400000@vervain.sonytel.be> <1065560111.3366.33.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065560111.3366.33.camel@dhcppc4>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 07, 2003 at 04:55:11PM -0400, Len Brown wrote:

 > > In 2.4.21, both `halt' and `reboot' work fine.
 > Did you configure with ACPI in 2.4.21?
 > If you configured with APM in 2.4.21, you might consider sticking with
 > it rather than switching to ACPI in 2.4.22.

So power-off on shutdown with acpi is actually working for some folks?
None of my boxes seem to work with it any more. I'm not sure when
this started, but its been that way for a while, in both 2.4 and 2.6test

 > Also, if there is a BIOS update available for this system you should
 > consider it.

Rocking horse poop is probably easier to find than Sony VAIO BIOS updates. 
I spent an afternoon once being bounced around from one Sony
flash-ridden site to another to no avail..

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
