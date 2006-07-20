Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWGTAvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWGTAvY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 20:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWGTAvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 20:51:23 -0400
Received: from smtp.hickorytech.net ([216.114.192.16]:16870 "EHLO
	avalanche.hickorytech.net") by vger.kernel.org with ESMTP
	id S964887AbWGTAvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 20:51:23 -0400
Message-ID: <44BF19DA.9060403@mnsu.edu>
Date: Thu, 20 Jul 2006 00:51:22 -0500
From: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
Cc: Mattias Hedenskog <ml@magog.se>, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com
Subject: Re: XFS breakage in 2.6.18-rc1
References: <67dc30140607190717r57ed2fe5w719dcca896110d8@mail.gmail.com> <44BE48D5.7020107@mnsu.edu> <20060720090109.F1947140@wobbly.melbourne.sgi.com>
In-Reply-To: <20060720090109.F1947140@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott wrote:
> On Wed, Jul 19, 2006 at 09:59:33AM -0500, Jeffrey E. Hundstad wrote:
>   
>> I did try the xfs_repair 2.8.4 for a volume running on 2.6.17.4 and it 
>> annihilated the volume.  This volume was not showing signs of crashing.  
>> So... I guess I would certainly not run xfs_repair unless there is good 
>> reason.
>>     
>
> Erm, wha..?  Can you expand on "annihilated" a bit?  (please send
> me the full xfs_repair output if you still have it).
>   

Nathan Scott,

I'm very sorry; I don't have the output anymore.  By annihilated I mean 
that there were several directories trees that /didn't work/.  If you 
tried to cd into the directory or take a directory listing... or used a 
file that you knew was in these certain directories then you'd get pages 
of debug message to the console; and no usable data.  I re-ran 
xfs_repair and retried several times but the condition never seemed to 
improve or get worse for that matter.

I /incorrectly/ figured it was a known issue or I'd have saved the 
output.  Sorry again.

-- 
Jeffrey Hundstad

