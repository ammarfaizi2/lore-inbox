Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSHSLY0>; Mon, 19 Aug 2002 07:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314811AbSHSLY0>; Mon, 19 Aug 2002 07:24:26 -0400
Received: from dsl-213-023-038-065.arcor-ip.net ([213.23.38.65]:65502 "EHLO
	starship") by vger.kernel.org with ESMTP id <S313181AbSHSLYZ>;
	Mon, 19 Aug 2002 07:24:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] printk from userspace
Date: Mon, 19 Aug 2002 13:28:47 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Benjamin LaHaise <bcrl@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.21.0208140016140.3712-100000@weyl.math.psu.edu> <3D59E365.B0115D78@zip.com.au> <3D59EB50.6050801@zytor.com>
In-Reply-To: <3D59EB50.6050801@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17gkiG-0003Cq-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 August 2002 07:32, H. Peter Anvin wrote:
> Alright, klibc 0.35 uses /dev/kmsg for syslog(3).

Could we please have '/dev/kmessage' instead of 'kmsg'?

-- 
Daniel
