Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283338AbRLDTSu>; Tue, 4 Dec 2001 14:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282910AbRLDTRc>; Tue, 4 Dec 2001 14:17:32 -0500
Received: from natwar.webmailer.de ([192.67.198.70]:5557 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S283302AbRLDTRN>; Tue, 4 Dec 2001 14:17:13 -0500
Message-ID: <3C0D20E2.9040801@korseby.net>
Date: Tue, 04 Dec 2001 20:15:46 +0100
From: Kristian Peters <kristian.peters@korseby.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: de, en
MIME-Version: 1.0
To: Matt Bernstein <matt@theBachChoir.org.uk>
CC: nbecker@fred.net, linux-kernel@vger.kernel.org
Subject: Re: nfs: task can't get a request slot
In-Reply-To: <Pine.LNX.4.33.0112040921170.2274-100000@nick.dcs.qmul.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Bernstein wrote:

> Have a look at adglinux1 and see if its NFS server is still alive.
> Your hung processes should "unhang" when rpppc1 can see the server again.


That's right. But in meantime my load increases to 150.. (I had that 
yesterday...) Isn't there a way to force it shutdown even if there's no response 
? I thought that would be possible by mounting it soft ?

*Kristian

