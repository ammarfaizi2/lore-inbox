Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbVACXKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVACXKn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 18:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVACXJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:09:38 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:38809 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261931AbVACXGA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:06:00 -0500
Message-ID: <41D9CFE0.6090002@tmr.com>
Date: Mon, 03 Jan 2005 18:06:08 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Adrian Bunk <bunk@stusta.de>, William Lee Irwin III <wli@debian.org>,
       Andries Brouwer <aebr@win.tue.nl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
References: <20050102221534.GG4183@stusta.de><1697129508.20050102210332@dns.toxicfilms.tv> <Pine.LNX.4.61.0501031019110.25392@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.61.0501031019110.25392@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Sun, 2 Jan 2005, Adrian Bunk wrote:
> 
>> The main advantage with stable kernels in the good old days (tm) when 4
> 
> 
>> Nowadays in 2.6, every new 2.6 kernel has several regressions compared
>> to the previous one, and additionally obsolete but used code like
> 
> 
> 2.2 before 2.2.20 also had this kind of problem, as did
> the 2.4 kernel before 2.4.20 or thereabouts.
> 
> I'm pretty sure 2.6 is actually doing better than the
> early 2.0, 2.2 and 2.4 kernels...
> 
2.6 is doing better in terms of staying up, not eating my files, etc. 
I'm less sure about the things being 'changed' (by design) vs. 'broken' 
(by unintended bug introduction). My sense is that there are people who 
want to remove features which are not broken nor causing huge overhead 
or developer effort.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
