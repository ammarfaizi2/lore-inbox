Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbUJZVy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbUJZVy1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 17:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbUJZVy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 17:54:27 -0400
Received: from mail.tmr.com ([216.238.38.203]:39181 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261496AbUJZVyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 17:54:12 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: PROPOSAL:  New NEW development model
Date: Tue, 26 Oct 2004 17:56:41 -0400
Organization: TMR Associates, Inc
Message-ID: <417EC819.7030809@tmr.com>
References: <1098817715.9350.2.camel@weaponx.rchland.ibm.com><1098817715.9350.2.camel@weaponx.rchland.ibm.com> <417EA486.7070105@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1098827155 14946 192.168.12.100 (26 Oct 2004 21:45:55 GMT)
X-Complaints-To: abuse@tmr.com
Cc: Josh Boyer <jdub@us.ibm.com>, William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
To: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <417EA486.7070105@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:

> Still, a month or two to adapt to a new task scheduler out of 6 months
> leaves 4-5 months per stable release if the Volatile branch decides to
> hack up the scheduler.  This is still a better scenario then "VM and
> scheduler infrastructures may change on any given release."
> 
> 
> 
> So OK, that's what's good here; so what's wrong with it?  We've already
> established that there will be a minimal level of added work for a
> maintainer to keep the Stable up.  Are there any other drawbacks?  If
> not, any objections to trying to sell this one to Linus and Andrew?  :)

Knock yourself out, I would be happy if they would just agree not to 
take features out of a stable series or intentionally break them. If new 
features don't break the old ones I don't think there's a persuasive 
argument to keep them out.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
