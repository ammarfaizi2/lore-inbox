Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284836AbRLEXmi>; Wed, 5 Dec 2001 18:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284841AbRLEXm3>; Wed, 5 Dec 2001 18:42:29 -0500
Received: from zero.tech9.net ([209.61.188.187]:55044 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S284838AbRLEXmU>;
	Wed, 5 Dec 2001 18:42:20 -0500
Subject: Re: ext3-0.9.16 against linux-2.4.17-pre2
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: "ext3-users@redhat.com" <ext3-users@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C0B12C5.F8F05016@zip.com.au>
In-Reply-To: <3C0B12C5.F8F05016@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 05 Dec 2001 18:42:19 -0500
Message-Id: <1007595740.818.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-03 at 00:51, Andrew Morton wrote:
> An ext3 update which also applies to linux-2.4.16 is available at
> 
> 	http://www.zip.com.au/~akpm/linux/ext3/
> 
> Quite a lot of miscellany here.  It would be appreciated if interested
> parties could please test it in preparation for sending upstream.  Thanks.

Running 2.4.17-pre4 + preempt-kernel + ext3-0.9.16.

System survived a preliminary stress test, involving I/O and VM
pressure, with no problems.  Seems solid here.

Also, subjectively the combination of 2.4.17-pre2+ and this ext3 patch
yields better performance under load.  Can't comment which provide the
benefit without testing, but hey, it's the user experience that counts.

	Robert Love

