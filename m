Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319209AbSHNF22>; Wed, 14 Aug 2002 01:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319212AbSHNF22>; Wed, 14 Aug 2002 01:28:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18437 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319209AbSHNF22>; Wed, 14 Aug 2002 01:28:28 -0400
Message-ID: <3D59EB50.6050801@zytor.com>
Date: Tue, 13 Aug 2002 22:32:00 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Benjamin LaHaise <bcrl@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] printk from userspace
References: <Pine.GSO.4.21.0208140016140.3712-100000@weyl.math.psu.edu> <Pine.LNX.4.44.0208132123500.1208-100000@home.transmeta.com> <20020814003505.A16322@redhat.com> <3D59E365.B0115D78@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alright, klibc 0.35 uses /dev/kmsg for syslog(3).

	-hpa

