Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbRAXH3O>; Wed, 24 Jan 2001 02:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbRAXH3E>; Wed, 24 Jan 2001 02:29:04 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:65173 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129532AbRAXH2w>; Wed, 24 Jan 2001 02:28:52 -0500
Date: Tue, 23 Jan 2001 23:31:07 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: 2001-01-23 release of hotplug scripts
To: Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
        Linux-usb-users@lists.sourceforge.net
Message-id: <018201c085d7$9e82a9c0$6600000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
In-Reply-To: <20010116225518.C1733@kroah.com> <20010123221213.A19568@kroah.com>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also, PCI (Cardbus at least) support should behave
again, thanks to Dan Zink.

For USB hotplug, make sure you have modutils 2.4.2
(kernel 2.4.0 and later).

- Dave


----- Original Message -----
From: Greg KH <greg@kroah.com>
To: <linux-hotplug-devel@lists.sourceforge.net>; <linux-kernel@vger.kernel.org>;
<linux-usb-devel@lists.sourceforge.net>; <Linux-usb-users@lists.sourceforge.net>
Sent: Tuesday, January 23, 2001 10:12 PM
Subject: 2001-01-23 release of hotplug scripts


> I've just packaged up the latest hotplug scripts into a release, and
> they can be found at:
> http://download.sourceforge.net/linux-hotplug/hotplug-2001_01_23.tar.gz
> http://download.sourceforge.net/linux-hotplug/hotplug-2001_01_23-1.noarch.rpm
>   http://download.sourceforge.net/linux-hotplug/hotplug-2001_01_23-1.src.rpm
> depending on which format you prefer.
>
> Changes in this version from the last release are:
> - log "ifup" invocations when debugging for net.agent script
> - address some problems with hotplugging USB on 2.2
> - small change in the .spec file from Chmouel Boudjnah
>
> thanks,
>
> greg k-h
>
> --
> greg@(kroah|wirex).com
>
> _______________________________________________
> Linux-hotplug-devel mailing list  http://linux-hotplug.sourceforge.net
> Linux-hotplug-devel@lists.sourceforge.net
> http://lists.sourceforge.net/lists/listinfo/linux-hotplug-devel

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
