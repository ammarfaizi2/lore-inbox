Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272242AbTHDVHm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 17:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272243AbTHDVHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 17:07:42 -0400
Received: from mail.kroah.org ([65.200.24.183]:64926 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272242AbTHDVHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 17:07:41 -0400
Date: Mon, 4 Aug 2003 13:57:07 -0700
From: Greg KH <greg@kroah.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 1041] New: oops in scsi_device_get after inserting a USB camera (usb-storage)2.6.0-test2
Message-ID: <20030804205706.GA16241@kroah.com>
References: <435120000.1060028540@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435120000.1060028540@flay>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 01:22:20PM -0700, Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=1041
> 
>            Summary: oops in scsi_device_get after inserting a USB camera
>                     (usb-storage)2.6.0-test2:
>     Kernel Version: 2.6.0-test2
>             Status: NEW
>           Severity: normal
>              Owner: greg@kroah.com
>          Submitter: santamarta@gmx.net

Already re-assigned to the scsi people as it's not a usb bug :)

When is the email-to-bugzilla interface going to be working?

thanks,

greg k-h
