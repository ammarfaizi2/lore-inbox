Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbVH2QJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbVH2QJz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 12:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVH2QJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 12:09:49 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:50185 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751092AbVH2QJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 12:09:38 -0400
Message-ID: <4313349E.9000406@tmr.com>
Date: Mon, 29 Aug 2005 12:15:26 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jeff shia <tshxiayu@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is cdrecord dependent on some kind of bus type?
References: <7cd5d4b4050829044626df8b38@mail.gmail.com>
In-Reply-To: <7cd5d4b4050829044626df8b38@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jeff shia wrote:
> Hello,
> 
> 
> Is cdrecord dependent on some kind of bus type,such as pci or usb?
> And the older version such as cdrecord-1.2?
> can cdrecord-1.2 run on kernel-2.4.18?

Why not ask the cdrecord M/L? Subscribe at other.debian.org.

Any 2.4 kernel should work using ide-scsi.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
