Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbUDAIBU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 03:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUDAIBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 03:01:20 -0500
Received: from mta5.adelphia.net ([68.168.78.187]:47091 "EHLO
	mta5.adelphia.net") by vger.kernel.org with ESMTP id S262753AbUDAIBT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 03:01:19 -0500
Message-ID: <406BC690.2080803@adelphia.net>
Date: Thu, 01 Apr 2004 02:36:48 -0500
From: Cory Tusar <ctusar@adelphia.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sf.net>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] multiple namespaces
References: <1080800087.1490.14.camel@cube>
In-Reply-To: <1080800087.1490.14.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> +/* drive letter support */
> +#define PR_GET_DRIVE 42     /* get the current drive */
> +#define PR_SET_DRIVE 69     /* set the current drive */
> +#define PR_SUBST_CREATE 666   /* associate a drive letter with something */
> +#define PR_SUBST_DESTROY 20040401   /* kill a drive letter */

My bogometer just twitched...

