Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbULEAFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbULEAFe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 19:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbULEAFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 19:05:31 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:63972 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S261205AbULEAFZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 19:05:25 -0500
Message-ID: <41B250DA.8080308@verizon.net>
Date: Sat, 04 Dec 2004 19:05:46 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: Lee Revell <rlrevell@joe-job.com>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Alessandro Amici <alexamici@fastwebnet.it>,
       Miguel Angel Flores <maf@sombragris.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel development environment
References: <41B1F97A.80803@sombragris.com>	 <200412042121.49274.alexamici@fastwebnet.it>	 <41B22381.10008@sombragris.com>	 <200412042237.48729.alexamici@fastwebnet.it>	 <1102196829.28776.46.camel@krustophenia.net>	 <41B22EDE.2060009@stud.feec.vutbr.cz> <1102200355.28776.58.camel@krustophenia.net> <41B24A46.2010802@osdl.org>
In-Reply-To: <41B24A46.2010802@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [209.158.220.243] at Sat, 4 Dec 2004 18:05:24 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> Lee Revell wrote:
> 
>> On Sat, 2004-12-04 at 22:40 +0100, Michal Schmidt wrote:
>>
>>> Lee Revell wrote:
>>>
>>>> In case you did not get the joke, Mozilla Mail is one of the WORST mail
>>>> clients for handling kernel patches.  See the list archives.
>>>
>>>
>>> Mozilla works fine if you send patches as attachments.
>>>
>>
>>
>> I still say it's broken.
>>
>> http://lkml.org/lkml/2004/10/22/488
> 
> 
> so don't use copy-paste.  that idea is broken.
> 
> otoh, netscape/mozilla/thunderbird mail
> all work fine (except that attachments are required,
> instead of being able to insert patches inline).
> 

After inadvertently helping to discover the bug in Mozilla, I use the sendpatchset 
script written by Paul Jackson at:

http://www.speakeasy.org/~pj99/sgi/sendpatchset

That lets people's patch-collecting scripts work properly, since (apparently) most 
of the m choke on the MIME headers from attachments.

If you need to connect directly to your ISP, Paul sent me a fix I can forward.
