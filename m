Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262567AbVFVWcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbVFVWcz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 18:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262565AbVFVWae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 18:30:34 -0400
Received: from 64-60-250-34.cust.telepacific.net ([64.60.250.34]:11290 "EHLO
	panta-1.pantasys.com") by vger.kernel.org with ESMTP
	id S262519AbVFVW0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 18:26:13 -0400
Message-ID: <42B9E582.80408@pantasys.com>
Date: Wed, 22 Jun 2005 15:26:10 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: YhLu <YhLu@tyan.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 with dual way dual core ck804 MB
References: <3174569B9743D511922F00A0C94314230A40468C@TYANWEB> <20050621221218.GE14251@wotan.suse.de>
In-Reply-To: <20050621221218.GE14251@wotan.suse.de>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jun 2005 22:23:26.0031 (UTC) FILETIME=[021FBDF0:01C57779]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tue, Jun 21, 2005 at 02:41:52PM -0700, YhLu wrote:
> It works for me on several dual core systems, except on a very big
> one that seems to run into a scheduler problem.

I'm having similar problems with a 16P x86_64. If I boot it with 
maxcpus=8 I have no problems. Is there some info that might be useful to 
help debug this problem?

thanks,

peter
