Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317833AbSFSKWz>; Wed, 19 Jun 2002 06:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317834AbSFSKWy>; Wed, 19 Jun 2002 06:22:54 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:25017 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S317833AbSFSKWx>; Wed, 19 Jun 2002 06:22:53 -0400
Message-ID: <3D105B3E.8090801@antefacto.com>
Date: Wed, 19 Jun 2002 11:21:50 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Cort Dougan <cort@fsmlabs.com>
CC: Benjamin LaHaise <bcrl@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
References: <E17KPdj-0004EP-00@wagner.rustcorp.com.au> <Pine.LNX.4.44.0206181334500.981-100000@home.transmeta.com> <20020618171200.G16091@redhat.com> <20020618150840.Q13770@host110.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cort Dougan wrote:
> I agree with you there.  It's not easy, and I'd claim it's not possible
> given that no-one has done it yet, to have a select() call that is speedy
> for both 0-10 and 1k file descriptors.

Have you noticed yesterdays + todays fixup patch from Andi Kleen:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102446644619648&w=2

Padraig.

