Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbSK0DPK>; Tue, 26 Nov 2002 22:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261446AbSK0DPK>; Tue, 26 Nov 2002 22:15:10 -0500
Received: from f270.law8.hotmail.com ([216.33.240.145]:53772 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S261426AbSK0DPJ>;
	Tue, 26 Nov 2002 22:15:09 -0500
X-Originating-IP: [24.44.249.150]
From: "sean darcy" <seandarcy@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: modutils for both redhat kernels and 2.5.x
Date: Tue, 26 Nov 2002 22:22:22 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F2708IgEO3YnDKvLVFD000016ca@hotmail.com>
X-OriginalArrivalTime: 27 Nov 2002 03:22:23.0175 (UTC) FILETIME=[339B7570:01C295C4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK.OK So there's no way to boot both.

FWIW, modutils-2.4.21-4 works fine with built 2.4.19 and 2.4.20-rc3 kernels. 
While modprobe -c does give errors, all the rh scripts seem to work fine.

AND, rh's position on all this:

"You need *entirely different* modutils, not just a new modutils. We 
probably
won't be looking into this until the new 2.5 module loader is actually 
finished" Bugzilla 78508

So if you want to try 2.5 kernels, make your own 2.4.x, you can't use the rh 
kernels.











_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online 
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

