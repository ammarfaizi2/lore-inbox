Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264126AbTDOWAl (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 18:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264127AbTDOWAl 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 18:00:41 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:18898 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264126AbTDOWAj 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 18:00:39 -0400
Date: Tue, 15 Apr 2003 15:07:46 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Robert Love <rml@tech9.net>, gert.vervoort@hccnet.nl,
       tconnors@astro.swin.edu.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.67: ppa driver & preempt == oops
Message-ID: <20030415150746.A32019@beaverton.ibm.com>
References: <3E982AAC.3060606@hccnet.nl> <1050172083.2291.459.camel@localhost> <3E993C54.40805@hccnet.nl> <1050255133.733.6.camel@localhost> <3E99A1E4.30904@hccnet.nl> <20030415120000.A30422@beaverton.ibm.com> <1050442676.3664.162.camel@localhost> <20030415145155.49df44c7.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030415145155.49df44c7.rddunlap@osdl.org>; from rddunlap@osdl.org on Tue, Apr 15, 2003 at 02:51:55PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 02:51:55PM -0700, Randy.Dunlap wrote:

> I have such a device at home.  I can try to test it (if the device
> still works).  What needs to be tested?

That would be nice.

AFAIK just attach and mount it, and probably dd to/from it, and then post
your fix :)

I think any removable scsi (direct access, not cdrom) media might show a
problem (see recent "USB Mass Storage Device" thread from Jim Beam).

> or maybe I can loan it to patmans for 1 day...

I don't have a machine (that I know will boot current 2.5) with a parallel
port.

I/we should get some removable media attached to one of our scsi systems
we have here (maybe usb storage).

-- Patrick Mansfield
