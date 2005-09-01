Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbVIAVTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbVIAVTj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbVIAVTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:19:38 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:13482 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750744AbVIAVTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:19:38 -0400
Date: Thu, 1 Sep 2005 22:19:19 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Pavel Machek <pavel@suse.cz>
Cc: seife@use.de, linux-kernel@vger.kernel.org
Subject: Re: [git tree] DRM tree for 2.6.14 (fwd)
In-Reply-To: <20050831185358.GE703@openzaurus.ucw.cz>
Message-ID: <Pine.LNX.4.58.0509012218020.20045@skynet>
References: <Pine.LNX.4.58.0508301018330.1102@skynet> <20050831185358.GE703@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is it the one that breaks suspend in suse kernels? It tends to load
> okay even on machines without savage hw, and then explodes on suspend...

I don't think anyone else has picked this up before.. DRM drivers only
load on their own pciids.. I can't see why the savage would cause issues
over any other one ...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

