Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWBRCK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWBRCK1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 21:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWBRCK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 21:10:26 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:51587 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1750776AbWBRCK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 21:10:26 -0500
Message-ID: <38280.128.2.140.234.1140228625.squirrel@128.2.140.234>
In-Reply-To: <1140226006.2733.150.camel@mindpipe>
References: <38629.128.237.252.29.1140200365.squirrel@128.237.252.29>
    <1140226006.2733.150.camel@mindpipe>
Date: Fri, 17 Feb 2006 21:10:25 -0500 (EST)
Subject: Re: need help/guide to convert 2.6 module to 2.4
From: "George P Nychis" <gnychis@cmu.edu>
To: "Lee Revell" <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.5.1 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I should have been more specific

I am trying to get the code running on a router that only has the 2.4 kernel and can only support the 2.4 kernel because of the chipset on it.  It seems to compile fine with the cross compiler, however I don't know if it will actually work... if it compiles will it likely work?  I don't know the differences between the 2.6 net code and 2.4 to look at it and see if it will be compatible.

- George


> On Fri, 2006-02-17 at 13:19 -0500, George P Nychis wrote:
>> Hey guys,
>> 
>> I found a module for the 2.6 kernel that I want to migrate for the 2.4
>> kernel.
>> 
>> It is for the XCP network protocol support, found here: 
>> http://home.online.no/~mosebe/xcp_code.tar.gz
>> 
>> 
>> I also posted the code for you to look at, I am only interested in the
>> router code: http://rafb.net/paste/results/WSMhKW65.html
>> 
>> Can anyone help me convert this for the 2.4 kernel?  If not can someone
>> please point me in the direction of a guide to do so?
>> 
>> Please CC me in your responses.
> 
> Why can't you just use 2.6?
> 
> Lee
> 
> 
> 


-- 

