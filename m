Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264026AbTHWB0K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 21:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263556AbTHWB0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 21:26:10 -0400
Received: from smtp1.brturbo.com ([200.199.201.149]:37550 "EHLO
	smtp1.brturbo.com") by vger.kernel.org with ESMTP id S264031AbTHWB0H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 21:26:07 -0400
Message-ID: <3F46C29E.2080305@PolesApart.wox.org>
Date: Fri, 22 Aug 2003 22:25:50 -0300
From: Alexandre Pereira Nunes <alex@PolesApart.wox.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Doubt: core not dumped when binary give up root privileges.
References: <3F466E2A.8040905@PolesApart.wox.org>
In-Reply-To: <3F466E2A.8040905@PolesApart.wox.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, now I took the time to read the kernel sources and found why it 
works like that, and also the "prctl" ioctl.

I guess this should do the trick.

Thanks for the people who gave me some suggestions,

Alexandre






