Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262177AbSIZEbR>; Thu, 26 Sep 2002 00:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262180AbSIZEbQ>; Thu, 26 Sep 2002 00:31:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50192 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262177AbSIZEbO>;
	Thu, 26 Sep 2002 00:31:14 -0400
Message-ID: <3D928EAF.9080209@pobox.com>
Date: Thu, 26 Sep 2002 00:35:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 4/4] increase traffic on linux-kernel
References: <3D928864.23666D93@digeo.com> <3D928C8B.5020609@pobox.com> <3D928D9F.7BF85410@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik wrote:
>>I disagree with this -- CONFIG_DEBUG_KERNEL should not enable any machinery.

> A separate config option then?

please.

To answer your other email, moving magic-sysrq outside 
CONFIG_DEBUG_KERNEL should probably be done, though IMO that does not 
obviate the need for a separate config option here.

thanks,

	Jeff



