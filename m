Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVACWyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVACWyp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVACWye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:54:34 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:35481 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261928AbVACWxa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 17:53:30 -0500
Message-ID: <41D9CCF5.1030809@tmr.com>
Date: Mon, 03 Jan 2005 17:53:41 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
References: <20050102212427.GG2818@pclin040.win.tue.nl><1697129508.20050102210332@dns.toxicfilms.tv> <Pine.LNX.4.61.0501031011410.25392@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.61.0501031011410.25392@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Sun, 2 Jan 2005, Andries Brouwer wrote:
> 
>> You change some stuff. The bad mistakes are discovered very soon.
>> Some subtler things or some things that occur only in special
>> configurations or under special conditions or just with
>> very low probability may not be noticed until much later.
> 
> 
> Some of these subtle bugs are only discovered a year
> after the distribution with some particular kernel has
> been deployed - at which point the kernel has moved on
> so far that the fix the distro does might no longer
> apply (even in concept) to the upstream kernel...
> 
> This is especially true when you are talking about really
> big database servers and bugs that take weeks or months
> to trigger.
> 
There is a reason why people pay big bucks to Redhat (and others) for a 
five year contract to back port the bug fixes to the original kernel and 
software. Barring some huge change I need, I expect to run AS3.0 for 
four more years for one application, "learning experiences" are not a 
good thing.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
