Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266888AbRGOTrs>; Sun, 15 Jul 2001 15:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266893AbRGOTri>; Sun, 15 Jul 2001 15:47:38 -0400
Received: from beasley.gator.com ([63.197.87.202]:58122 "EHLO
	beasley.gator.com") by vger.kernel.org with ESMTP
	id <S266888AbRGOTrW>; Sun, 15 Jul 2001 15:47:22 -0400
From: "George Bonser" <george@gator.com>
To: "Lew Wolfgang" <wolfgang@train.sweet-haven.com>,
        "Steve VanDevender" <stevev@efn.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Linux default IP ttl
Date: Sun, 15 Jul 2001 12:51:48 -0700
Message-ID: <CHEKKPICCNOGICGMDODJEEFODKAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <Pine.LNX.4.33.0107151211010.20532-100000@train.sweet-haven.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> However, sometimes doing the right thing will cause you to loose
> the war.  I recall that early Solaris systems had a problem,
> the details of which I forget, where web browsers of a certain
> very large company would fail.  Apparently the Solaris tcp-ip stack
> was strictly adhering to the RFC's, it was the other large company's
> stack that didn't conform.  If memory serves, there was a raging
> discussion at the time about whether this non-conformance was
> intentional in an effort to target Solaris as an inferior web
> server platform.  Solaris bowed to the inevitable.

I *THINK* there was some Path MTU Discovery thing that did not always work
properly with some BSD 4.2 derived stacks. It has been a long time.

