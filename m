Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWIBJzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWIBJzE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 05:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWIBJzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 05:55:04 -0400
Received: from gw.goop.org ([64.81.55.164]:9387 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750960AbWIBJzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 05:55:03 -0400
Message-ID: <44F954F7.5020008@goop.org>
Date: Sat, 02 Sep 2006 02:55:03 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Kay Sievers <kay.sievers@suse.de>, andrew@digital-domain.net
Subject: Re: [Bugme-new] [Bug 7065] New: Devices no longer automount
References: <200608281700.k7SH0CYl013187@fire-2.osdl.org> <20060828121057.035fd690.akpm@osdl.org> <20060902094239.GH26849@kroah.com> <44F95364.8020901@goop.org> <20060902095143.GA27196@kroah.com>
In-Reply-To: <20060902095143.GA27196@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> Are you having this same problem?  I think it was an invalid HAL
> configuration file from what I heard.  Kay would know for sure.
>   

Yes.  The automounting device stuff has always been a bit random.  It 
worked at first with a fresh FC6-T1 install, but it has become pretty 
flakey lately.  I'd never got around to trying to track down how it all 
really works.

    J

-- 
VGER BF report: H 3.01476e-12
