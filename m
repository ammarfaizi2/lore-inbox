Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbVLDXrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVLDXrO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 18:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbVLDXrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 18:47:14 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:40913 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932272AbVLDXrN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 18:47:13 -0500
Date: Mon, 5 Dec 2005 00:50:39 +0100
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tejun Heo <htejun@gmail.com>
Subject: Re: Linux 2.6.15-rc3 problem found - scsi order changed
Message-ID: <20051204235039.GA27826@aitel.hist.no>
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org> <20051129213656.GA8706@aitel.hist.no> <Pine.LNX.4.64.0511291340340.3029@g5.osdl.org> <438D69FF.2090002@aitel.hist.no> <438EB150.2090502@pobox.com> <20051204004302.GA2188@aitel.hist.no> <Pine.LNX.4.64.0512031702110.3099@g5.osdl.org> <Pine.LNX.4.64.0512040110280.27389@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512040110280.27389@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 01:34:18AM -0800, Zwane Mwaikambo wrote:
> On Sat, 3 Dec 2005, Linus Torvalds wrote:
> 
> Yes that fixed it, but why walk into usb/ on CONFIG_PCI?

The patch worked for me also, and 2.6.15-rc5 is ok too. :-)

Helge Hafting
