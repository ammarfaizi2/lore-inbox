Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267760AbUHEPq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267760AbUHEPq1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 11:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267759AbUHEPpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 11:45:53 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:64235 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S267629AbUHEPoy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 11:44:54 -0400
From: David Brownell <david-b@pacbell.net>
To: Norbert Preining <preining@logic.at>
Subject: Re: [linux-usb-devel] 2.6.8-rc2-mm2 with usb and input problems
Date: Thu, 5 Aug 2004 08:37:38 -0700
User-Agent: KMail/1.6.2
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20040802162845.GA24725@gamma.logic.tuwien.ac.at> <200408041926.31293.david-b@pacbell.net> <20040805065153.GC3984@gamma.logic.tuwien.ac.at>
In-Reply-To: <20040805065153.GC3984@gamma.logic.tuwien.ac.at>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408050837.38757.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 August 2004 23:51, Norbert Preining wrote:
> Hi David!
> 
> On Mit, 04 Aug 2004, David Brownell wrote:
> > Not clear how to read that stack; if it's usbdev_open()
> > that's making the trouble, lock_kernel() is blocked.
> > But that doesn't quite make sense to me.  Sorry!
> 
> So what now? Should I make other programs hang and check for the trace
> there, and hope to find another trace? Or ignore it for now?

You can ignore hangs?  My!

Check other traces, surely something will make more sense.

- Dave
