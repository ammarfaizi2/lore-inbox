Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133018AbREAMQT>; Tue, 1 May 2001 08:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133120AbREAMQJ>; Tue, 1 May 2001 08:16:09 -0400
Received: from cs.columbia.edu ([128.59.16.20]:679 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S133018AbREAMQA>;
	Tue, 1 May 2001 08:16:00 -0400
Date: Tue, 1 May 2001 05:15:57 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrea Arcangeli <andrea@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.19 locks up on SMP
In-Reply-To: <15086.42872.321353.67228@charged.uio.no>
Message-ID: <Pine.LNX.4.33.0105010514340.14530-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2001, Trond Myklebust wrote:

> Did you apply the following patch which I put out on the lists a
> couple of weeks ago?

No, I was testing with 2.2.19 and then I started going back into the 
2.2.19pre series until I found the culprit.

I'll give your patch a spin tomorrow, after I catch some zzz's. :-)

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

