Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbTJHAJY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 20:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbTJHAJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 20:09:24 -0400
Received: from mail1.dac.neu.edu ([129.10.1.75]:25606 "EHLO mail1.dac.neu.edu")
	by vger.kernel.org with ESMTP id S262887AbTJHAJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 20:09:22 -0400
Message-ID: <3F83545A.2030900@ccs.neu.edu>
Date: Tue, 07 Oct 2003 20:03:38 -0400
From: Stan Bubrouski <stan@ccs.neu.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Len Brown <len.brown@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Dimitri Torfs <dimitri@sonycom.com>, acpi-devel@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: vaio doesn't poweroff with 2.4.22 (fwd)
References: <Pine.GSO.4.21.0310022254280.8802-400000@vervain.sonytel.be> <1065560111.3366.33.camel@dhcppc4> <20031007234655.GA10471@redhat.com>
In-Reply-To: <20031007234655.GA10471@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> On Tue, Oct 07, 2003 at 04:55:11PM -0400, Len Brown wrote:
> 
>  > > In 2.4.21, both `halt' and `reboot' work fine.
>  > Did you configure with ACPI in 2.4.21?
>  > If you configured with APM in 2.4.21, you might consider sticking with
>  > it rather than switching to ACPI in 2.4.22.
> 
> So power-off on shutdown with acpi is actually working for some folks?
> None of my boxes seem to work with it any more. I'm not sure when
> this started, but its been that way for a while, in both 2.4 and 2.6test
> 
>  > Also, if there is a BIOS update available for this system you should
>  > consider it.
> 
> Rocking horse poop is probably easier to find than Sony VAIO BIOS updates. 
> I spent an afternoon once being bounced around from one Sony
> flash-ridden site to another to no avail..
> 
> 		Dave
> 

You can find bios updates at http://ciscdb.sel.sony.com/cgi-bin/select-p-n.pl
if you go to drivers and select other OS, but the bios
updates are listed as runnable in XP...

-sb


