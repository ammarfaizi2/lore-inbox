Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268592AbUHLPbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268592AbUHLPbf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 11:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268595AbUHLPbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 11:31:31 -0400
Received: from mail.tmr.com ([216.238.38.203]:36881 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S268599AbUHLPb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 11:31:29 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Linux Kernel bug report (includes fix)
Date: Thu, 12 Aug 2004 11:35:10 -0400
Organization: TMR Associates, Inc
Message-ID: <cfg25a$euu$1@gatekeeper.tmr.com>
References: <200408101234.i7ACYdwP013901@burner.fokus.fraunhofer.de><200408101234.i7ACYdwP013901@burner.fokus.fraunhofer.de> <4118F6AC.7080903@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1092324330 15326 192.168.12.100 (12 Aug 2004 15:25:30 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <4118F6AC.7080903@jg555.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Gifford wrote:
> There is a simple fix to your problem, I have sent this patch to you a 
> few times, but never got an answer.
> 
> I bet eveyone here will agree, this is the proper way to fix the issue

Everyone has agreed that not using kernel headers is the proper way to 
fix the issue. Joerg can include the extracted and cleansed headers 
released regularly and include them in his software.

The whole ide that no one can compile his application unless they have 
the kernel source online is a non-starter in the first place.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
