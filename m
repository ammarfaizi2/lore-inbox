Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSEANGJ>; Wed, 1 May 2002 09:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311948AbSEANGI>; Wed, 1 May 2002 09:06:08 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:20213 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S311885AbSEANGH>; Wed, 1 May 2002 09:06:07 -0400
Message-ID: <3CCFE83F.B858A101@redhat.com>
Date: Wed, 01 May 2002 14:06:07 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-0.24smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in "page_alloc.c" with 2.4.19-pre7-ac2
In-Reply-To: <Pine.GSO.4.44.0205011113420.1714-100000@gerber>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alastair Stevens wrote:
> 
> Just a small problem report observed with my Athlon system running
> 2.4.19-pre7-ac2 under RH 7.2.93 (skipjack beta):
> 
> Basically, "page_alloc.c" generated a BUG error when unmounting my
> filesystems during a reboot. I wasn't able to capture the full output,
> but I hope may be useful to report this anyway. If it happens again I'll
> try to grab the details....
> 
> But this fault seems *not* to be repeatable - I rebooted several times
> with no problems, and my filesystems also appear to be fine.

Are you using the nvidia driver by chance ?
