Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263027AbUKTQWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263027AbUKTQWz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 11:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263029AbUKTQUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 11:20:33 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:9648 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263027AbUKTQUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 11:20:04 -0500
Message-ID: <419F6EB9.4020207@namesys.com>
Date: Sat, 20 Nov 2004 08:20:09 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tridge@samba.org
CC: Anton Altaparmakov <aia21@cam.ac.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: performance of filesystem xattrs with Samba4
References: <16797.41728.984065.479474@samba.org>	<1100865833.6443.17.camel@imp.csi.cam.ac.uk>	<16797.60034.186288.663343@samba.org>	<Pine.LNX.4.60.0411191352050.8634@hermes-1.csi.cam.ac.uk> <16799.8212.96811.520317@samba.org>
In-Reply-To: <16799.8212.96811.520317@samba.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tridge@samba.org wrote:

>
>yep, I'm looking forward to experimenting with the "file is a
>directory" stuff in reiser4 to see how well it can be made to match
>what is needed for Samba4. 
>
>  
>
There are still bugs with it that have us turning it off for now, but I 
think we will fix those in the next year.
