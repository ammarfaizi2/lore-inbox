Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265298AbTLMVMo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 16:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265299AbTLMVMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 16:12:44 -0500
Received: from ppp-RAS1-2-226.dialup.eol.ca ([64.56.225.226]:7040 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S265298AbTLMVMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 16:12:43 -0500
Date: Sat, 13 Dec 2003 16:12:34 -0500
From: William Park <opengeometry@yahoo.ca>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multiple keyboard/monitor vs linux-2.6?
Message-ID: <20031213211234.GB448@node1.opengeometry.net>
Mail-Followup-To: Helge Hafting <helgehaf@aitel.hist.no>,
	linux-kernel@vger.kernel.org
References: <fa.da53dsa.dho216@ifi.uio.no> <20031212214310.GA744@node1.opengeometry.net> <20031213131405.GA11073@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031213131405.GA11073@hh.idb.hist.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 13, 2003 at 02:14:05PM +0100, Helge Hafting wrote:
> On Fri, Dec 12, 2003 at 04:43:10PM -0500, William Park wrote:
> > On Fri, Dec 12, 2003 at 09:13:28AM +0000, Boszormenyi Zoltan wrote:
> > > 
> > > The functionality can be found at linuxconsole.sourceforge.net.
> > > Will this be included into mainline near term? Say 2.6.[12]?
> > > The ruby-2.6 is against 2.6.0-test9 so it's almost uptodate.
> > 
> > Does it work?
> > 
> It works with 2.6.0-test11.  Prepare a kernel source tree,
> check out ruby from cvs, copy the ruby-2.6 parts into
> the kernel tree.
> 
> I run my home machine this way:
> 2 standard keyboards, one connected to the keyboard port and
> another connected to the ps2 mouse port.

Plug PS/2 keyboard into PS/2 mouse port???  I didn't know you can do
that.

> 2 mice, both connected to serial ports.
> 2 screens, connected to the two outputs of a matrox G550.

-- 
William Park, Open Geometry Consulting, <opengeometry@yahoo.ca>
Linux solution for data management and processing. 
