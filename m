Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266197AbUG0BBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266197AbUG0BBk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 21:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266205AbUG0BAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 21:00:52 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:125 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266200AbUG0BAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 21:00:49 -0400
Message-ID: <4105A93C.5030109@yahoo.com.au>
Date: Tue, 27 Jul 2004 11:00:44 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Jan-Frode Myklebust <janfrode@parallab.uib.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: OOM-killer going crazy.
References: <20040725094605.GA18324@zombie.inka.de> <41045EBE.8080708@comcast.net> <20040726091004.GA32403@ii.uib.no> <4104E307.1070004@yahoo.com.au> <20040726111032.GA2067@ii.uib.no> <4104EE5C.406@yahoo.com.au> <20040726124628.GA2488@ii.uib.no>
In-Reply-To: <20040726124628.GA2488@ii.uib.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Frode Myklebust wrote:

>On Mon, Jul 26, 2004 at 09:43:24PM +1000, Nick Piggin wrote:
>
>>Can you try echo 10000 > /proc/sys/vm/vfs_cache_pressure, and see how that 
>>goes?
>>
>
>
>Yes! Now it works. So is vfs_cache_pressure=10000 a sensible value to use? 
>
>

Well if it keeps you going then yes. For now. I'll get back to you with
something to try though.

Thanks.


