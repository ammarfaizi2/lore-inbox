Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVCMOYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVCMOYj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 09:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVCMOYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 09:24:39 -0500
Received: from smtp05.web.de ([217.72.192.209]:52615 "EHLO smtp05.web.de")
	by vger.kernel.org with ESMTP id S261212AbVCMOYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 09:24:36 -0500
Message-ID: <42344D0F.8050900@web.de>
Date: Sun, 13 Mar 2005 15:24:15 +0100
From: Torben Viets <Viets@web.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: XFS dm_crypt BUG?
References: <422214D6.2000206@web.de> <422220C7.8090001@xfs.org> <20050228092215.F2644066@wobbly.melbourne.sgi.com> <422B6885.7090908@web.de> <20050307080929.B2751595@wobbly.melbourne.sgi.com>
In-Reply-To: <20050307080929.B2751595@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

it works with Kernel 2.6.11, probably the problem was that I had used 4 
kb stacks and now I use the 8kb, but I'm not sure whether this was the 
problem.

greetings
Torben Viets

Nathan Scott schrieb:

>On Sun, Mar 06, 2005 at 09:31:01PM +0100, Torben Viets wrote:
>  
>
>>hello,
>>
>>I tried to reproduced the bug with the newest kernel and but it works 
>>perfectly :D
>>
>>thnk you for fixing it.
>>    
>>
>
>No problem, thanks for checking - could you send a note to the
>list(s) saying its resolved for you with that kernel version, in
>case others have also been seeing the problem.
>
>cheers.
>
>  
>

