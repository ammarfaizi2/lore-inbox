Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262546AbUJ0UUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbUJ0UUF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 16:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUJ0URQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:17:16 -0400
Received: from mail.tmr.com ([216.238.38.203]:58384 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262546AbUJ0UOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:14:00 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Setting 32bit IO on SATA drives
Date: Wed, 27 Oct 2004 16:16:34 -0400
Organization: TMR Associates, Inc
Message-ID: <41800222.3020606@tmr.com>
References: <1098827414l.6518l.0l@werewolf.able.es><1098827414l.6518l.0l@werewolf.able.es> <417F0597.6030103@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1098907543 22109 192.168.12.100 (27 Oct 2004 20:05:43 GMT)
X-Complaints-To: abuse@tmr.com
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
To: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <417F0597.6030103@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
>  > HDIO_GET_MULTCOUNT failed: Operation not supported
> 
> Fyi, I have removed that bogus error message from my
> working copy of hdparm.

I thought it wasn't supported. I presume you mean you detected that the 
operation should not be attempted rather than causing an error to fail 
silently.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
