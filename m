Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264160AbUFXKKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264160AbUFXKKy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 06:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbUFXKKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 06:10:53 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:34734 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264183AbUFXKKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 06:10:52 -0400
Message-ID: <40DAA8A9.80000@yahoo.com.au>
Date: Thu, 24 Jun 2004 20:10:49 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Yusuf Goolamabbas <yusufg@outblaze.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: finish_task_switch high in profiles in 2.6.7
References: <20040624091548.GA8264@outblaze.com> <40DA9E89.9020801@yahoo.com.au> <20040624093440.GA8422@outblaze.com> <40DAA2D2.9010008@yahoo.com.au> <20040624100543.GB8422@outblaze.com>
In-Reply-To: <20040624100543.GB8422@outblaze.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yusuf Goolamabbas wrote:
>>OK. They're both using 100% CPU... is 2.6.5 getting more work done?
> 
> 
> So far, it looks like both are doing similar amount of work. am getting
> more measurements from other boxes
> 
> My concern was the high system usage, I had suspected that it might have
> been due interrupts generated on the NIC. This was not evident in the
> profile I generated
> 

OK, keep me CCed on any further developments. In particular if
context switches are up or performance is down.

Thanks
Nick
