Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbTJVRji (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 13:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263351AbTJVRjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 13:39:37 -0400
Received: from b107150.adsl.hansenet.de ([62.109.107.150]:61399 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S263203AbTJVRjg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 13:39:36 -0400
Message-ID: <3F96C0CC.7010903@ppp0.net>
Date: Wed, 22 Oct 2003 19:39:24 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Simmons <jsimmons@infradead.org>
CC: Prasad <prasad@atc.tcs.co.in>, linux-kernel@vger.kernel.org
Subject: Re: [REPOST] The Linux Progress Patch for 2.6 Kernels
References: <Pine.LNX.4.44.0310221803470.25125-100000@phoenix.infradead.org>
In-Reply-To: <Pine.LNX.4.44.0310221803470.25125-100000@phoenix.infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
>>Prasad wrote:
>>
>>>The patch was made against 2.6.0-Test5 but should
>>>perfectly work for the recent ones too.
>>
>>I need the following patch w/ test8-mm1 to get it compile. Otherwise it 
>>works quite well (i810fb). The screen is a bit distorted for the first 
>>few messages after elpp kicks in and the bottom line, where the messages 
>>appear, isn't cleared to the end. Also the background right of the eye 
>>is changing from black to red in the middle of the boot progress for no 
>>apparent reason (I've no supporting bootscripts).
> 
> 
> ???? What is elpp ?

LPP for 2.6?! See [1] and Prasad's earlier post [2] about it.
i810fb is working great without it - thanks for your work :).

Jan

[1] http://students.iiit.net/~prasad_s/lpp/
[2]
http://marc.theaimsgroup.com/?l=linux-kernel&m=106681497425277&w=2

