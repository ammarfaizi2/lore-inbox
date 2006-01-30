Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbWA3TEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWA3TEd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 14:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWA3TEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 14:04:33 -0500
Received: from dvhart.com ([64.146.134.43]:62856 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S964879AbWA3TEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 14:04:32 -0500
Message-ID: <43DE633E.60803@mbligh.org>
Date: Mon, 30 Jan 2006 11:04:30 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4
References: <20060129144533.128af741.akpm@osdl.org>
In-Reply-To: <20060129144533.128af741.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm4/
> 
> - New git tree `git-davej-x86.patch': misc x86 things, maintained by David
>   Jones.
> 
> - Lots of USB updates.  Please be sure to Cc:
>   linux-usb-devel@lists.sourceforge.net if something broke.
> 
> - Various other random bits and pieces.  Things have been pretty quiet
>   lately - most activity seems to be concentrated about putting bugs into the
>   various subsystem trees.
> 
> - If you have a patch in -mm which you think should go into 2.6.16, it
>   doesn't hurt to remind me.  There's quite a lot here which will go into
>   2.6.16.


On a more positive note than usual, AFAICS this pretty much works on all 
the platforms I was looking at on http://test.kernel.org ... performance
regressions gone and everything. Happy test people boing boing boing ;-)

M.


