Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264909AbUFRBAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264909AbUFRBAw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 21:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264910AbUFRBAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 21:00:52 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:59360 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S264909AbUFRBAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 21:00:46 -0400
Message-ID: <40D23EBD.50600@opensound.com>
Date: Thu, 17 Jun 2004 18:00:45 -0700
From: 4Front Technologies <dev@opensound.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Stop the Linux kernel madness
References: <40D232AD.4020708@opensound.com> <20040618004450.GT12308@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040618004450.GT12308@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Thu, Jun 17, 2004 at 05:09:17PM -0700, 4Front Technologies wrote:
> 
>>Hi Folks,
>>
>>I am writing this message to bring a huge problem to light. SuSE has been 
>>systematically
>>forking the linux kernel and shipping all kinds of modifications and still 
>>call their
>>kernels 2.6.5 (for example).
>>
>>Either they ship the stock Linux kernel sources or they stop calling their 
>>distributions
>>as Linux-2.6.x based.
>>
>>Kernel headers are being changed willy-nilly and SuSE are completely 
>>running rough-shod
>>over the linux kernel with the result ONLY software from SuSE works.
> 
> 
> "Software" == "3rd-party kernel modules" in this case, right?
> 
> Remember what had been told to you about in-kernel interfaces?  That's
> right, that they can be changed at zero notice.  Now, if SuSE told you
> otherwise, you might have a cause to complain.  Had they?
> 
> If they'd promised in-kernel interface stability and lied - sure, go ahead
> and nail them to the wall.  If not - STFU and eat what you are bloody given.
> 
> Al, not particulary fond of SuSE, but even less so - of misdirecting wankers
> like that...
> 


That's right Al, 4Front, ATI, Nvidia are all evil!. OK so now get on with life.

It's time everybody started to pay some attention to in-kernel interfaces because
Linux has graduated out of your personal sandbox to where other people want to use
Linux and they aren't kernel developers.

Sure we can fix the problem with SuSE - we've been doing this for the past 7 years.
And we know a thing or two about Linux kernels but wouldn't it be better for the
Linux community in general to have such source issue stabilized?



best regards

Dev Mazumdar
---------------------------------------------------------------------
4Front Technologies
4035 Lafayette Place, Unit F, Culver City, CA 90232, USA
Tel: 310 202 8530   Fax: 310 202 0496   URL: http://www.opensound.com
---------------------------------------------------------------------

