Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbUKKRnC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbUKKRnC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 12:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUKKRjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 12:39:10 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:61896 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262325AbUKKRZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:25:47 -0500
Message-ID: <41BB2D9A.9010703@namesys.com>
Date: Sat, 11 Dec 2004 09:25:46 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>, vs <vs@thebsh.namesys.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm5: REISER4_LARGE_KEY is still selectable
References: <20041111012333.1b529478.akpm@osdl.org> <20041111165045.GA2265@stusta.de>
In-Reply-To: <20041111165045.GA2265@stusta.de>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>REISER4_LARGE_KEY is still selectable in reiser4-include-reiser4.patch 
>(and we agreed that it shouldn't be).
>
>cu
>Adrian
>
>  
>
thanks for catching that, vs, please fix and send patch.
