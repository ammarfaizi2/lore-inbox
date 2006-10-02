Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWJBP0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWJBP0J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 11:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWJBP0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 11:26:09 -0400
Received: from dvhart.com ([64.146.134.43]:17539 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S964781AbWJBP0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 11:26:07 -0400
Message-ID: <45212F39.5000307@mbligh.org>
Date: Mon, 02 Oct 2006 08:24:41 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Spam, bogofilter, etc
References: <1159539793.7086.91.camel@mindpipe>	 <20061002100302.GS16047@mea-ext.zmailer.org> <1159802486.4067.140.camel@mindpipe>
In-Reply-To: <1159802486.4067.140.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Mon, 2006-10-02 at 13:03 +0300, Matti Aarnio wrote:
>> I do think that Markov Chains combined with Bayes Statistics 
>> might do a wee bit better.  (Except with very short emails.)
>> However all that these things are able to do is essentially
>> grow the key database when spammers are producing new mutated
>> (mis-spelled) texts by mixing in spaces, punctuations, and even
>> occasional characters.
>>
>> For recognizing those pill merchants one needs complex software
>> to read the site at the URL, and to read texts out of the IMAGES
>> at the site.  Captcha to get thru spam filters...
>>
> 
> Could a heuristic be added to reject messages with wildly incorrect
> dates?  I notice that the last 5-10 messages in my LKML folder every
> morning are spam with a date that's ~24 hours in the future.

If you got rid of "slut" and "schoolgirl" that'd get rid of half of it.

M.
