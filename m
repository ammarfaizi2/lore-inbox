Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268356AbUIQARY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268356AbUIQARY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 20:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268447AbUIQARX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 20:17:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28801 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268356AbUIQARN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 20:17:13 -0400
Message-ID: <414A2CFB.5000900@pobox.com>
Date: Thu, 16 Sep 2004 20:16:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tharbaugh@lnxi.com
CC: akpm@digeo.com, linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: Re: [PATCH] gen_init_cpio uses external file list
References: <1095372672.19900.72.camel@tubarao> <414A1C92.3070205@pobox.com> <1095375235.19900.82.camel@tubarao>
In-Reply-To: <1095375235.19900.82.camel@tubarao>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thayne Harbaugh wrote:
> On Thu, 2004-09-16 at 19:06 -0400, Jeff Garzik wrote:
> 
>>Seems OK to me...
>>
>>	Jeff, the original gen_init_cpio author
> 
> 
> There's been some minor discussion about the use of _GNU_SOURCE (needed
> for getline()).  Comments?  I can rework the getline() if anyone can
> make a case - otherwise I'm a bit lazy.


I am a bit leery of _GNU_SOURCE but whatever :)

