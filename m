Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWEIOp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWEIOp2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 10:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWEIOp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 10:45:28 -0400
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:64727 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751298AbWEIOp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 10:45:27 -0400
Message-ID: <445F95DC.4050109@tmr.com>
Date: Mon, 08 May 2006 15:02:52 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.2) Gecko/20060409 SeaMonkey/1.0.1
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Nigel Cunningham <ncunningham@cyclades.com>, linux-kernel@vger.kernel.org,
       stable@kernel.org, torvalds@osdl.org
Subject: Re: Linux 2.6.16.14
References: <20060505003526.GW24291@moss.sous-sol.org> <200605051152.39693.ncunningham@cyclades.com> <20060505023353.GA24291@moss.sous-sol.org> <200605050347.51703.s0348365@sms.ed.ac.uk>
In-Reply-To: <200605050347.51703.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> On Friday 05 May 2006 03:33, Chris Wright wrote:
>> * Nigel Cunningham (ncunningham@cyclades.com) wrote:
>>> Is this supposed to be some sort of subtle pressure on Linus to open 2.7?
>>> :>
>> He does every couple months and leaves it open for a few weeks.
>> Then, just to keep us guessing, he releases it with a 2.6 name ;-)
>>
>> Actually, I think the system is working quite well.  We've got a quick
>> route for getting bug fixes and security fixes to users, and a shorter
>> devel cycle helping distro folks get more regular drops from upstream.
> 
> I think it's working extremely well. When it comes to security fixes, I want 
> them as soon as possible. There's no sense batching them.
> 
> The only thing to be careful of is that -stable fixes (or complete reworks) 
> get merged with mainline, so the trees don't go out of sync. So far this 
> seems to have been OK.
> 
As I recall these patches may or may not go into mainline. The next full 
release may address the problem in a whole new way.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

