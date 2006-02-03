Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422895AbWBCTvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422895AbWBCTvF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422890AbWBCTvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:51:04 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:17170 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1422888AbWBCTvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:51:02 -0500
Message-ID: <43E3B3F3.8060107@cfl.rr.com>
Date: Fri, 03 Feb 2006 14:50:11 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <20060202062840.GI5501@mail> <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo> <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com> <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo> <43E27792.nail54 <20060203180421.GA57965@dspnet.fr.eu.org>
In-Reply-To: <20060203180421.GA57965@dspnet.fr.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Feb 2006 19:51:35.0944 (UTC) FILETIME=[3D724880:01C628FB]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14245.000
X-TM-AS-Result: No--1.300000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert wrote:
> Actually, since at that point in time HAL is the only way to do device
> discovery with the linux kernel, problems in HAL are problems in
> linux.  There is *no* other way than HAL to do the mapping between a
> point in the sysfs tree and a device node in /dev[1].

That information is available in /sys, which is how HAL discovers it.  
If you wanted to, you could bypass HAL and go directly to /sys to 
perform your own discovery.  Also HAL is not a part of the linux kernel, 
therefore a problem in HAL is NOT a problem in linux, even if there were 
no other way to get the information as you ( wrongly ) asserted. 


