Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312713AbSCZU4Z>; Tue, 26 Mar 2002 15:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312716AbSCZU4F>; Tue, 26 Mar 2002 15:56:05 -0500
Received: from CPE-203-51-26-123.nsw.bigpond.net.au ([203.51.26.123]:29423
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S312713AbSCZUzt>; Tue, 26 Mar 2002 15:55:49 -0500
Message-ID: <3CA0E051.918CF69@eyal.emu.id.au>
Date: Wed, 27 Mar 2002 07:55:45 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre3-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Announcement] patch-2.0.40-rc4
In-Reply-To: <20020317135322.J3301@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:
> 
> I'm releasing another -rc with this change, just to stick to my
> promise that the last pre-patch will be identical with the final
> release.
> 
> 2.0.40-rc4

I am trying to build on Debian, which is on gcc 2.95.4. I get some
asm errrors regarding illegal registers.

I did apply a patch linux-2.0.x.patch to fix some other errors.

Is there a patch to fix this or do I have to use an older gcc?

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
