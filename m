Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264127AbTDOWTb (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 18:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbTDOWTb 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 18:19:31 -0400
Received: from air-2.osdl.org ([65.172.181.6]:13758 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264127AbTDOWTa 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 18:19:30 -0400
Date: Tue, 15 Apr 2003 15:29:32 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: rml@tech9.net, gert.vervoort@hccnet.nl, tconnors@astro.swin.edu.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.67: ppa driver & preempt == oops
Message-Id: <20030415152932.23c830a9.rddunlap@osdl.org>
In-Reply-To: <20030415150746.A32019@beaverton.ibm.com>
References: <3E982AAC.3060606@hccnet.nl>
	<1050172083.2291.459.camel@localhost>
	<3E993C54.40805@hccnet.nl>
	<1050255133.733.6.camel@localhost>
	<3E99A1E4.30904@hccnet.nl>
	<20030415120000.A30422@beaverton.ibm.com>
	<1050442676.3664.162.camel@localhost>
	<20030415145155.49df44c7.rddunlap@osdl.org>
	<20030415150746.A32019@beaverton.ibm.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Apr 2003 15:07:46 -0700 Patrick Mansfield <patmans@us.ibm.com> wrote:

| On Tue, Apr 15, 2003 at 02:51:55PM -0700, Randy.Dunlap wrote:
| 
| > I have such a device at home.  I can try to test it (if the device
| > still works).  What needs to be tested?
| 
| That would be nice.
| 
| AFAIK just attach and mount it, and probably dd to/from it, and then post
| your fix :)

So I should test (and fix) 2.5.67-k.o and PREEMPT=y ??
Any other requirements?

| I think any removable scsi (direct access, not cdrom) media might show a
| problem (see recent "USB Mass Storage Device" thread from Jim Beam).
| 
| > or maybe I can loan it to patmans for 1 day...
| 
| I don't have a machine (that I know will boot current 2.5) with a parallel
| port.

IBM made some like that.  :)
Maybe you'll have to walk across the street tomorrow.

| I/we should get some removable media attached to one of our scsi systems
| we have here (maybe usb storage).

Yes, you should.  I have Zip SCSI, Zip Plus, Zip USB, USB hard drive,
and USB/IEEE1394 hard drive.

--
~Randy
