Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbTEMD4L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 23:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTEMD4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 23:56:11 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:31706 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262811AbTEMD4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 23:56:10 -0400
Date: Tue, 13 May 2003 05:08:49 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: re-scanning the PCI bus after boot for configurable device...
In-Reply-To: <20030513034147.GA5938@kroah.com>
Message-ID: <Pine.LNX.4.53.0305130507090.25655@skynet>
References: <Pine.LNX.4.53.0305130225240.20908@skynet> <20030513034147.GA5938@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I've posted a driver to the linux-hotplug-devel mailing list a year or
> so ago that might help you out with this.  On module load it rescans the
> PCI address space, adding or removind devices that are new or now gone.
> This will probably do what you want.

I persume it's this one
http://marc.theaimsgroup.com/?l=linux-hotplug-devel&m=101312609603679

and it looks the business, I don't have my hardware yet but I this answers
the is it possible question enough :-)

Thanks Greg,
Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person

