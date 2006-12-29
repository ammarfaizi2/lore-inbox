Return-Path: <linux-kernel-owner+w=401wt.eu-S1754920AbWL2PRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920AbWL2PRf (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 10:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754917AbWL2PRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 10:17:34 -0500
Received: from smtpout05-04.prod.mesa1.secureserver.net ([64.202.165.221]:59233
	"HELO smtpout05-04.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754916AbWL2PRe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 10:17:34 -0500
Message-ID: <4595318B.10102@seclark.us>
Date: Fri, 29 Dec 2006 10:17:31 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Michlmayr <tbm@cyrius.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ranma@tdiedrich.de, gordonfarquharson@gmail.com,
       Andrew Morton <akpm@osdl.org>, a.p.zijlstra@chello.nl,
       arjan@infradead.org, andrei.popa@i-neo.ro
Subject: Re: Ok, explained.. (was Re: [PATCH] mm: fix page_mkclean_one)
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org> <20061228114517.3315aee7.akpm@osdl.org> <Pine.LNX.4.64.0612281156150.4473@woody.osdl.org> <20061228.143815.41633302.davem@davemloft.net> <3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org> <Pine.LNX.4.64.0612282155400.4473@woody.osdl.org> <Pine.LNX.4.64.0612290017050.4473@woody.osdl.org> <Pine.LNX.4.64.0612290202350.4473@woody.osdl.org> <20061229140822.GH2062@deprecation.cyrius.com>
In-Reply-To: <20061229140822.GH2062@deprecation.cyrius.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Michlmayr wrote:

>* Linus Torvalds <torvalds@osdl.org> [2006-12-29 02:48]:
>  
>
>>Can anybody get corruption with this thing applied? It goes on top
>>of plain v2.6.20-rc2.
>>    
>>
>
>It works for me now, both your testcase as well as an installation of
>Debian on this ARM device.  I manually applied the patch to 2.6.19.
>
>Thanks.
>  
>
Hi Martin,

Can you post a diff against 2.6.19?

Thanks,
Steve

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



