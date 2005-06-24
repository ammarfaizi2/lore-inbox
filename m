Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263079AbVFXJR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbVFXJR1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 05:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbVFXJR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 05:17:27 -0400
Received: from gate.corvil.net ([213.94.219.177]:14345 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S263079AbVFXJRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 05:17:24 -0400
Message-ID: <42BBCF8A.5060409@draigBrady.com>
Date: Fri, 24 Jun 2005 10:16:58 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Jan Knutar <jk-lkml@sci.fi>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>,
       linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
Subject: Re: [ltp] Re: IBM HDAPS Someone interested?
References: <007301c575d9$77decb90$600cc60a@amer.sykes.com>	 <42B73BB7.4030906@linuxwireless.org> <1119310501.17602.1.camel@mindpipe>	 <200506231833.34423.jk-lkml@sci.fi> <1119546519.32469.17.camel@mindpipe>
In-Reply-To: <1119546519.32469.17.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Thu, 2005-06-23 at 18:33 +0300, Jan Knutar wrote:
> 
>>On Tuesday 21 June 2005 02:35, Lee Revell wrote:
>>
>>
>>>I was thinking more along the lines of figure out the io port it's
>>>using, then boot windows, set an IO breakpoint in softice, then drop
>>>your laptop on the bed or something.
>>
>>io ports 0x2E, 0x2F and 0xED aren't assigned to anything "known"
>>on other computers, are they?

Generally watchdogs use 2[EF]

Pádraig.
