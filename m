Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318473AbSHEOPE>; Mon, 5 Aug 2002 10:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318488AbSHEOPE>; Mon, 5 Aug 2002 10:15:04 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:63480 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S318473AbSHEOPD>; Mon, 5 Aug 2002 10:15:03 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.NEB.4.44.0208041228060.1422-100000@mimas.fachschaften.tu-muenchen.de> 
References: <Pine.NEB.4.44.0208041228060.1422-100000@mimas.fachschaften.tu-muenchen.de> 
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.30-dj1 (sort of) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 05 Aug 2002 15:15:23 +0100
Message-ID: <25466.1028556923@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


bunk@fs.tum.de said:
>  the part of -dj1 below is obviously wrong (and it causes a compile
> error). After removing it the file compiles.

The -dj tree should have no changes to JFFS2. If there are any, they are 
patches which have passed me by for some reason so please resend them to me.

--
dwmw2


