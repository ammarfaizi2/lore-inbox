Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbVKNPyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbVKNPyW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 10:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVKNPyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 10:54:22 -0500
Received: from rtr.ca ([64.26.128.89]:31716 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751162AbVKNPyW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 10:54:22 -0500
Message-ID: <4378B327.3080301@rtr.ca>
Date: Mon, 14 Nov 2005 10:54:15 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.xx:  dirty pages never being sync'd to disk?
References: <4378ADB2.7040905@rtr.ca> <1131982550.2821.41.camel@laptopd505.fenrus.org> <4378B1FB.1060201@rtr.ca>
In-Reply-To: <4378B1FB.1060201@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are all of the values from /proc/sys/vm/

     0  block_dump
    10  dirty_background_ratio
  3000  dirty_expire_centisecs
    40  dirty_ratio
   500  dirty_writeback_centisecs
     0  laptop_mode
     0  legacy_va_layout
   256 32  lowmem_reserve_ratio
65536  max_map_count
  3831  min_free_kbytes
     2  nr_pdflush_threads
     0  overcommit_memory
    50  overcommit_ratio
     3  page-cluster
    60  swappiness
   300  swap_token_timeout
   100  vfs_cache_pressure
