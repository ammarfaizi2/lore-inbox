Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293500AbSCFMNA>; Wed, 6 Mar 2002 07:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293507AbSCFMMu>; Wed, 6 Mar 2002 07:12:50 -0500
Received: from [195.63.194.11] ([195.63.194.11]:45831 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S293500AbSCFMMj>; Wed, 6 Mar 2002 07:12:39 -0500
Message-ID: <3C86077C.8030709@evision-ventures.com>
Date: Wed, 06 Mar 2002 13:11:40 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
In-Reply-To: <E16ia7t-0000N9-00@roos.tartu-labor>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos wrote:
> MD> 2. It convinced me that the current task-file interface in linux
> MD>     is inadequate. So Alan please bear with me if your CF format
> MD>     microdrive will have to not wakeup properly for some time...
> MD>     The current mess will just have to go before something more
> MD>     adequate can go in.
> 
> Why not keep the existing taskfile implementation in until you complete the
> elegant implementation?

It's still there ;-). However doing it this way is nearly impossible
since there is no continuous transition line.

