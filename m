Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbVFVXcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbVFVXcO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 19:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbVFVXcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 19:32:14 -0400
Received: from 64-60-250-34.cust.telepacific.net ([64.60.250.34]:47132 "EHLO
	panta-1.pantasys.com") by vger.kernel.org with ESMTP
	id S262580AbVFVXbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 19:31:32 -0400
Message-ID: <42B9F4D3.9070208@pantasys.com>
Date: Wed, 22 Jun 2005 16:31:31 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: YhLu <YhLu@tyan.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 with dual way dual core ck804 MB
References: <3174569B9743D511922F00A0C94314230A40468C@TYANWEB> <20050621221218.GE14251@wotan.suse.de> <42B9E582.80408@pantasys.com> <20050622231053.GB14251@wotan.suse.de>
In-Reply-To: <20050622231053.GB14251@wotan.suse.de>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jun 2005 23:28:46.0296 (UTC) FILETIME=[22C8B580:01C57782]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> There are two problems on AMD >8P. First the APIC addressing doesn't
> work and needs to be done differently (I have a patch for that
> in the final stages of testing). And then there is a mysterious
> scheduler deadlock problem in 2.6.12 that I haven't tracked down yet. 
> 2.6.11+patch works though.

okay, feel free to toss me the patch when your comfortable with it.

thanks,

peter
