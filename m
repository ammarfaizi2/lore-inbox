Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263727AbTETLyM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 07:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263729AbTETLyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 07:54:12 -0400
Received: from navigator.sw.com.sg ([213.247.162.11]:26041 "EHLO
	navigator.sw.com.sg") by vger.kernel.org with ESMTP id S263727AbTETLyL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 07:54:11 -0400
From: Vladimir Serov <vserov@infratel.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <3ECA1A66.7090404@infratel.com>
Date: Tue, 20 May 2003 16:07:02 +0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: Re: [BUG] nfs client stuck in D state in linux 2.4.17 - 2.4.21-pre5
References: <20030318155731.1f60a55a.skraw@ithnet.com>	<3E79EAA8.4000907@infratel.com>	<15993.60520.439204.267818@charged.uio.no>	<3E7ADBFD.4060202@infratel.com> <shsof45nf58.fsf@charged.uio.no>	<3E7B0051.8060603@infratel.com>	<15995.578.341176.325238@charged.uio.no>	<3E7B10DF.5070005@infratel.com>	<15995.5996.446164.746224@charged.uio.no>	<3E7B1DF9.2090401@infratel.com>	<15995.10797.983569.410234@charged.uio.no>	<3EC8DA1B.50304@infratel.com> <shsel2uqsh0.fsf@charged.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>Did you try the patch I sent you last week? (appended below)
>
>Cheers,
>  Trond
>
Yes I do, Trond.
It doesn't help, and probably shouldn't, because it's UP not SMP system.

Cheers, Vladimir.
