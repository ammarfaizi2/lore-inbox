Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbUCRTTw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 14:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262895AbUCRTTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 14:19:52 -0500
Received: from mail1.fw-sj.sony.com ([160.33.82.68]:45753 "EHLO
	mail1.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S262894AbUCRTTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 14:19:40 -0500
Message-ID: <4059F863.3040206@am.sony.com>
Date: Thu, 18 Mar 2004 11:28:35 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Steve Longerbeam <stevel@mvista.com>, Dave Jones <davej@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: new special filesystem for consideration in 2.6/2.7
References: <40462AA1.7010807@mvista.com> <4048C245.7060009@mvista.com> <20040305184203.GB26176@redhat.com> <4048CE25.8010705@mvista.com> <404A919C.3070501@matchmail.com>
In-Reply-To: <404A919C.3070501@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> Steve Longerbeam wrote:
>> Dave Jones wrote:
>>> Without commenting on the code, the biggest thing holding back
>>> inclusion of this is likely the comment about there likely being
>>> patents held on parts of that code.
>>
>> Dave, true MV has a patent pending, but it would only affect any 
>> future use
>> of the technology in a _non GPL_ operating system. Used in Linux or any
>> future GPL software, no patent licenses or royalties are involved at all.
> 
> A statement in legal terms should be in the patch.

This statement is in a comment at the top of every file in
the patch:

  * This software is being distributed under the terms of the GNU General Public
  * License version 2.  Some or all of the technology encompassed by this
  * software may be subject to one or more patents pending as of the date of
  * this notice.  No additional patent license will be required for GPL
  * implementations of the technology.  If you want to create a non-GPL
  * implementation of the technology encompassed by this software, please
  * contact legal@mvista.com for details including licensing terms and fees.

I believe that this meets any required legal criteria for unencumbered
use in the Linux kernel (or other GPL projects).

=============================
Tim Bird
Architecture Group Co-Chair
CE Linux Forum
Senior Staff Engineer
Sony Electronics
E-mail: Tim.Bird@am.sony.com
=============================

