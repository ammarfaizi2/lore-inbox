Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbTLOUjE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 15:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbTLOUjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 15:39:04 -0500
Received: from ppp-RAS1-3-227.dialup.eol.ca ([64.56.226.227]:4992 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S261606AbTLOUjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 15:39:01 -0500
Date: Mon, 15 Dec 2003 15:38:58 -0500
From: William Park <opengeometry@yahoo.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: Multiple keyboard/monitor vs linux-2.6?
Message-ID: <20031215203858.GA287@node1.opengeometry.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <fa.da53dsa.dho216@ifi.uio.no> <20031212214310.GA744@node1.opengeometry.net> <20031213131405.GA11073@hh.idb.hist.no> <20031213211234.GB448@node1.opengeometry.net> <3FDDA686.6030502@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDDA686.6030502@aitel.hist.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 15, 2003 at 01:18:14PM +0100, Helge Hafting wrote:
> William Park wrote:
> >Plug PS/2 keyboard into PS/2 mouse port???  I didn't know you can do
> >that.
> 
> The two ports are the same hardware, which makes sense as they serve
> the same purpose - serial communication with a slow device.
> 
> The common case is one keyboard and one mouse, but two mice or two
> keyboards works just as well as long as the software expects it.
> Linux 2.6 have no problems with this.
> 
> You need the ruby patch to use the two keyboards independently, the
> standard kernel merges input from all attached keyboards into one
> console.
> 
> You may attach a lot more keyboards using usb keyboards.

Just tried it... works on 2.6, but not on 2.4.23.  Damn, I didn't have
to out and pay real money for USB keyboard/mouse. :-)

-- 
William Park, Open Geometry Consulting, <opengeometry@yahoo.ca>
Linux solution for data management and processing. 
