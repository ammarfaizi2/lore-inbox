Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbUCaRiA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 12:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbUCaRiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 12:38:00 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:51463 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262182AbUCaRh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 12:37:58 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3-mm2
Date: Wed, 31 Mar 2004 19:37:41 +0200
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>
References: <20040331014351.1ec6f861.akpm@osdl.org>
In-Reply-To: <20040331014351.1ec6f861.akpm@osdl.org>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200403311937.41510@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 March 2004 11:43, Andrew Morton wrote:

Hi Jens,

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc3/2.6
>.5-rc3-mm2/
> cfq-4.patch
>   CFQ io scheduler
>   CFQ fixes

is there any reason why I see /sys/block/hda/queue/iosched/ beeing empty? I 
thought every I/O scheduler would put in there some tunables or at least some 
info's what defaults are used. Or did I miss something completely and now I 
am totally wrong?

Thanks.

ciao, Marc
