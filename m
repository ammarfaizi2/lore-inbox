Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266839AbRGOT22>; Sun, 15 Jul 2001 15:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266853AbRGOT2S>; Sun, 15 Jul 2001 15:28:18 -0400
Received: from cx48762-a.cv1.sdca.home.com ([24.0.158.22]:24648 "EHLO
	train.sweet-haven.com") by vger.kernel.org with ESMTP
	id <S266839AbRGOT2L>; Sun, 15 Jul 2001 15:28:11 -0400
Date: Sun, 15 Jul 2001 12:28:01 -0700 (PDT)
From: Lew Wolfgang <wolfgang@train.sweet-haven.com>
To: Steve VanDevender <stevev@efn.org>
cc: George Bonser <george@gator.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Linux default IP ttl
In-Reply-To: <15185.57310.203036.847687@tzadkiel.efn.org>
Message-ID: <Pine.LNX.4.33.0107151211010.20532-100000@train.sweet-haven.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Jul 2001, Steve VanDevender wrote:

> To the extent that the Internet works today, it's because people have
> chosen to do the right thing instead of just the thing that works.
> Encouraging (not "bullying") other people to do the right thing is
> always a good idea.

However, sometimes doing the right thing will cause you to loose
the war.  I recall that early Solaris systems had a problem,
the details of which I forget, where web browsers of a certain
very large company would fail.  Apparently the Solaris tcp-ip stack
was strictly adhering to the RFC's, it was the other large company's
stack that didn't conform.  If memory serves, there was a raging
discussion at the time about whether this non-conformance was
intentional in an effort to target Solaris as an inferior web
server platform.  Solaris bowed to the inevitable.

Thus, we have the possibility that parameters may get modified to
gain competitive advantage.  While it's nice to stand on principle,
is that really what you want to do in this case?

Regards,
Lew Wolfgang

