Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbVKWPww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbVKWPww (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVKWPwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:52:01 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:51107 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751145AbVKWPvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:51:08 -0500
Message-ID: <4383979F.6070608@tmr.com>
Date: Tue, 22 Nov 2005 17:11:43 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Christmas list for the kernel
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
In-Reply-To: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> There have been recent comments about the pace of kernel development
> slowing. What are the major areas that still need major work? When the
> thread slows down maybe Linus will tell us what the top ten items
> really are.
> 
> To get things started here's a few that I would add:
> 
> 1) graphics, it is a total mess.
> 
> 2) get Xen merged, virtualization will be key on the server.
> Hotplugable CPUs and memory are tied up in this one.
> 
Serious question, when/if xen is in the kernel, is there a reason for 
UML? If so, why would I use UML instead of xen, and where?

I'm looking at a project eventually headed for a blade server, clearly 
some cost saving in the testing environment would be nice.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

