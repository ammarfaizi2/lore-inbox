Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbTDKUjn (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 16:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTDKUjn (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 16:39:43 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:1250 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S261789AbTDKUjl convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 16:39:41 -0400
From: David Lang <david.lang@digitalinsight.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Jeremy Jackson'" <jerj@coplanar.net>, "'Greg KH'" <greg@kroah.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-hotplug-devel@lists.sourceforge.net'" 
	<linux-hotplug-devel@lists.sourceforge.net>
Date: Fri, 11 Apr 2003 13:48:17 -0700 (PDT)
Subject: RE: [ANNOUNCE] udev 0.1 release
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780BEBAA44@orsmsx116.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0304111347370.8422-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ant then you also have all the same problems as devfs about default
permissions, making permissions persistant across reboots, etc.

David Lang

On Fri, 11 Apr 2003, Perez-Gonzalez, Inaky wrote:

> Date: Fri, 11 Apr 2003 13:42:58 -0700
> From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
> To: 'Jeremy Jackson' <jerj@coplanar.net>, 'Greg KH' <greg@kroah.com>
> Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
>      "'linux-hotplug-devel@lists.sourceforge.net'"
>     <linux-hotplug-devel@lists.sourceforge.net>
> Subject: RE: [ANNOUNCE] udev 0.1 release
>
>
> > From: Jeremy Jackson [mailto:jerj@coplanar.net]
> >
> > What about read-only root fs?
>
> /dev on a tmpfs?
>
> Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
> (and my fault)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
