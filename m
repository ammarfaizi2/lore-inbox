Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbRDEX1C>; Thu, 5 Apr 2001 19:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129598AbRDEX0w>; Thu, 5 Apr 2001 19:26:52 -0400
Received: from www.resilience.com ([209.245.157.1]:13712 "EHLO
	www.resilience.com") by vger.kernel.org with ESMTP
	id <S129524AbRDEX0j>; Thu, 5 Apr 2001 19:26:39 -0400
Message-ID: <3ACCFF6A.9BD08DBD@resilience.com>
Date: Thu, 05 Apr 2001 16:27:38 -0700
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 3 kmalloc underallocation bugs
In-Reply-To: <200104052245.PAA29663@csl.Stanford.EDU> <20010406011301.A11046@sm.luth.se> <3ACCFF07.5AF0A74A@resilience.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

André Dahlqvist wrote:
>
> Dawson Engler <engler@csl.Stanford.EDU> wrote:
> > enclosed are three bugs found in the 2.4.1 kernel by an extension
>
> Why are you guys running these tests against an already old kernel?
> I would suggest running it against at least Linus' latest version, or
> preferably Alan's -ac tree.

At least the two bugs in emu10k1/midi.c still exist in 2.4.3.

Just because 2.4.3 is a later version, doesn't mean all the bugs are
fixed from earlier versions.

-Jeff

-- 
Jeff Golds
jgolds@resilience.com
