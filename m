Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263979AbUGAFxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263979AbUGAFxZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 01:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264044AbUGAFxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 01:53:25 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:33371 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263979AbUGAFxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 01:53:24 -0400
Message-ID: <40E3A6D1.8070300@yahoo.com.au>
Date: Thu, 01 Jul 2004 15:53:21 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Frieder Buerzele <stamm@flashmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-np2
References: <40E00EA4.8060205@yahoo.com.au> <40E345BC.2070008@flashmail.com>
In-Reply-To: <40E345BC.2070008@flashmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frieder Buerzele wrote:
> must I still renice X to get your patch run without responsive-lose 
> during I/O e.g with cdparanoia?

It would help if X were reniced, yes. Try it and see though.

> thx
> 
> I had to edit fs/hfsplus/inode.c to get it compile properly
> 

Thanks.
