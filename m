Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136001AbREANnF>; Tue, 1 May 2001 09:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136611AbREANmz>; Tue, 1 May 2001 09:42:55 -0400
Received: from mons.uio.no ([129.240.130.14]:3762 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S136001AbREANml>;
	Tue, 1 May 2001 09:42:41 -0400
MIME-Version: 1.0
Message-ID: <15086.48447.264388.289216@charged.uio.no>
Date: Tue, 1 May 2001 15:42:23 +0200
To: Ion Badulescu <ionut@cs.columbia.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrea Arcangeli <andrea@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.19 locks up on SMP
In-Reply-To: <Pine.LNX.4.33.0105010514340.14530-100000@age.cs.columbia.edu>
In-Reply-To: <15086.42872.321353.67228@charged.uio.no>
	<Pine.LNX.4.33.0105010514340.14530-100000@age.cs.columbia.edu>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Ion Badulescu <ionut@cs.columbia.edu> writes:

     > On Tue, 1 May 2001, Trond Myklebust wrote:
    >> Did you apply the following patch which I put out on the lists
    >> a couple of weeks ago?

     > No, I was testing with 2.2.19 and then I started going back
     > into the 2.2.19pre series until I found the culprit.

     > I'll give your patch a spin tomorrow, after I catch some
     > zzz's. :-)

Right you are.

FYI I've now put up those patches of which I am aware against 2.2.19
on

  http://www.fys.uio.no/~trondmy/src/2.2.19

I'll try to keep that area updated with a brief explanation for each
patch...

Cheers,
  Trond
