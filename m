Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263068AbTDFUU1 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 16:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbTDFUU1 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 16:20:27 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:23768 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263068AbTDFUUZ (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 16:20:25 -0400
Date: Sun, 6 Apr 2003 21:31:45 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Nick Urbanik <nicku@vtc.edu.hk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Debugging hard lockups (hardware?)
Message-ID: <20030406203145.GA5783@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Nick Urbanik <nicku@vtc.edu.hk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3E8FC9FB.A030ACFB@vtc.edu.hk> <1049654048.1600.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049654048.1600.11.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 06, 2003 at 07:34:09PM +0100, Alan Cox wrote:
 > > 02:0a.0 RAID bus controller: CMD Technology Inc PCI0680 (rev 01)
 > > 02:0b.0 RAID bus controller: CMD Technology Inc PCI0680 (rev 01)
 > ...
 > Your choice of components looks fine, its all stuff I trust, even if the
 > ethernet card is not good for performance it ought to be fine in
 > general. If it is a faulty part most likely its a one off fault.

Note the IDE controller, and 2.5 bugzilla #123
That controller has been nothing but trouble for me.

		Dave

