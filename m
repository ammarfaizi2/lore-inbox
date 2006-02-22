Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbWBVXVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbWBVXVu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbWBVXVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:21:50 -0500
Received: from twin.uoregon.edu ([128.223.214.27]:24507 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id S1030343AbWBVXVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:21:49 -0500
Date: Wed, 22 Feb 2006 15:21:40 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: "Jeff V. Merkey" <jmerkey@soleranetworks.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Red Hat ES4 GPL Issues?
In-Reply-To: <43FCFDC6.9090109@soleranetworks.com>
Message-ID: <Pine.LNX.4.64.0602221519540.5009@twin.uoregon.edu>
References: <43FCFDC6.9090109@soleranetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2006, Jeff V. Merkey wrote:

>
> I have been working on 2.6.9 kernels with red hat ES4 series distributions 
> (we purchased and have a license).  I noticed that the ES4 series kernels
> which support NPTL libs no longer provide the source code with the 
> distribution (the installed kernels sources point to empty source trees which
> only contain makefiles).   I have discovered we have to use our Red Hat 
> Network account in order to download the Source RPMs
> (which are in fact provided).
>
> We got the distro via electronic fullfilment, so we did not get the SRPMS CD 
> iso images by default.  This was a deviation from how Red Hat
> normally distributes source code with their Linux distro.
>
> I am curious if Red Hat views requiring people subscribing to RHN as a 
> requirement to obtain source code is in conflict with the GPL.  We
> have no objection to downloading it since we have an account, but I found it 
> strange Red Hat, the leaders in Open Source and GPL
> technology, now appear to block downloads of ES4 source code without a 
> subscription.  Have I got it all wrong here, or is this borderline GPL
> avoidance?
>
> I am unable to locate the Source Code on any public servers at Red Hat.

is this the one you're looking for:

ftp://ftp.redhat.com/pub/redhat/linux/enterprise/4/en/os/i386/SRPMS/kernel-2.6.9-5.EL.src.rpm

ftp://ftp.redhat.com/pub/redhat/linux/updates/enterprise/4WS/en/os/SRPMS/kernel-2.6.9-22.0.2.EL.src.rpm

> Jeff
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2

