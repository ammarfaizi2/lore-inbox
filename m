Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265479AbTFMSPq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 14:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265476AbTFMSN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 14:13:28 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:49652 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265475AbTFMSNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 14:13:22 -0400
Date: Fri, 13 Jun 2003 11:26:43 -0700
From: Greg KH <greg@kroah.com>
To: Steven Dake <sdake@mvista.com>
Cc: Patrick Mochel <mochel@osdl.org>, Oliver Neukum <oliver@neukum.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-ID: <20030613182643.GF6037@kroah.com>
References: <Pine.LNX.4.44.0306130942040.908-100000@cherise> <3EEA0577.8050200@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EEA0577.8050200@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 10:10:15AM -0700, Steven Dake wrote:
> Brian Jackson has said there are 50 disks in the OSDL cluster, of which 
> he could put 3 partitions on, which would test 150 device enumerations.

You can also create 2000+ virtual disks today on your desktop using
scsi-debug to eliminate any hardware spin up times :)

thanks,

greg k-h
