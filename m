Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279334AbRJWJvF>; Tue, 23 Oct 2001 05:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279336AbRJWJu4>; Tue, 23 Oct 2001 05:50:56 -0400
Received: from t2.redhat.com ([199.183.24.243]:8189 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S279334AbRJWJuj>; Tue, 23 Oct 2001 05:50:39 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011022211622.B20411@virtucon.warpcore.org> 
In-Reply-To: <20011022211622.B20411@virtucon.warpcore.org>  <20011022172742.B445@virtucon.warpcore.org> <E15vnuN-0003jW-00@the-village.bc.nu> <20011022203159.A20411@virtucon.warpcore.org> <20011022214324.A18888@alcove.wittsend.com> 
To: drevil@warpcore.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Oct 2001 10:50:55 +0100
Message-ID: <17998.1003830655@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


drevil@warpcore.org said:
>  What I am advocating is a little bit more sanity. The OS should not
> break compatability with existing drivers so often for a 'stable'
> release.

Name a driver in the 2.4.13-pre6 tree which doesn't compile and work with 
the 2.4.13-pre6 kernel. 

We don't care about binary-only modules. That policy is fixed in stone - if
you don't like it, you are missing the point of what many of us are here
for. In which case, please go away and stop trolling.


On 7 Feb 1999, torvalds@transmeta.com wrote:
> I _refuse_ to even consider tying my hands over some binary-only module.
> 
> <...>
>
> Basically, I want people to know that when they use binary-only modules,
> it's THEIR problem.  I want people to know that in their bones, and I
> want it shouted out from the rooftops.  I want people to wake up in a
> cold sweat every once in a while if they use binary-only modules. 

	(ref: http://lwn.net/1999/0211/a/lt-binary.html)



--
dwmw2


