Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbVAABVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVAABVp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 20:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVAABVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 20:21:45 -0500
Received: from mail.tmr.com ([216.238.38.203]:8648 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S262171AbVAABVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 20:21:42 -0500
Message-ID: <41D5FDCE.2090905@tmr.com>
Date: Fri, 31 Dec 2004 20:33:02 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux lover <linux_lover2004@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: why there is different kernel versions from RedHat?
References: <20041231133525.47475.qmail@web52205.mail.yahoo.com>
In-Reply-To: <20041231133525.47475.qmail@web52205.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux lover wrote:
> Hi all,
> Where can i get special pathces used by RedHat to
> original kernels from www.kernel.org?

Three step process
1 - get the RH source RPM and unpack
2 - get the kernel.org source of the same number
3 - use diff to generate the patch.

Optional step 4 - look at the size of it, shake your head and swear.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
