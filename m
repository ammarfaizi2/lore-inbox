Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293378AbSCARC1>; Fri, 1 Mar 2002 12:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293381AbSCARCR>; Fri, 1 Mar 2002 12:02:17 -0500
Received: from [195.63.194.11] ([195.63.194.11]:4109 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S293378AbSCARCM>;
	Fri, 1 Mar 2002 12:02:12 -0500
Message-ID: <3C7FB3E2.5040807@evision-ventures.com>
Date: Fri, 01 Mar 2002 18:01:22 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: thread groups bug?
In-Reply-To: <22890.1015000691@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Hi Linus,
> 
> I've attached a patch to kill all subsidiary threads in a thread group when
> the main thread exits. I've made it against 2.5.6-pre1 since -pre2 fails to
> compile in the IDE code somewhere.

Just please enable support for IDE chipset tuning and it should at least
compile.

