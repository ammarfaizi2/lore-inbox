Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292534AbSBZRyl>; Tue, 26 Feb 2002 12:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292485AbSBZRyc>; Tue, 26 Feb 2002 12:54:32 -0500
Received: from [195.63.194.11] ([195.63.194.11]:17415 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292478AbSBZRyW>; Tue, 26 Feb 2002 12:54:22 -0500
Message-ID: <3C7BCB9B.7050207@evision-ventures.com>
Date: Tue, 26 Feb 2002 18:53:31 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: "Rose, Billy" <wrose@loislaw.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
In-Reply-To: <4188788C3E1BD411AA60009027E92DFD063077D8@loisexc2.loislaw.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rose, Billy wrote:
> "So the pain for the sysadmin will certainly not be decreased."
> 
> My company can tolerate 0% loss of data (which is why I raised this issue).
> The sysadmin's pain would be standing in the unemployment line if a file
> could not be recovered (which is currently from a heap of tapes that may
> take many hours to locate). The issue is not an easier job, but data
> integrity. Any sysadmin would state that every user at some point in time
> will delete something that is critical. Hell, I've done it myself on my own
> workstation after staring at the screen for 15 hours on a Saturday. The
> ability to handle situations like a file going "poof" is why my company will
> not use Linux on these particular file servers. My aim was to change that by
> crushing the only thing holding Netware in my company.

Ever tought of adding some *archiving* features to samba - fully
transparent to the users and still no need to mess around with the
kernel? And last but not least - much easier to implement correctly,
if the only thing you wan't is to crash netware...

