Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317073AbSGCRU4>; Wed, 3 Jul 2002 13:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317083AbSGCRUz>; Wed, 3 Jul 2002 13:20:55 -0400
Received: from [213.4.129.129] ([213.4.129.129]:26505 "EHLO tsmtp10.mail.isp")
	by vger.kernel.org with ESMTP id <S317073AbSGCRUy>;
	Wed, 3 Jul 2002 13:20:54 -0400
Date: Wed, 3 Jul 2002 19:25:03 +0200
From: Diego Calleja <diegocg@teleline.es>
To: khromy@lnuxlab.ath.cx (khromy)
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: sync slowness. ext3 on VIA vt82c686b
Message-Id: <20020703192503.32b5412b.diegocg@teleline.es>
In-Reply-To: <20020703043655.GA3346@lnuxlab.ath.cx>
References: <20020703022051.GA2669@lnuxlab.ath.cx>
	<3D226E86.695D27F3@zip.com.au>
	<20020703033538.GA3004@lnuxlab.ath.cx>
	<3D227621.B0A5C826@zip.com.au>
	<20020703040301.GA3233@lnuxlab.ath.cx>
	<20020703043655.GA3346@lnuxlab.ath.cx>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2002 00:36:55 -0400
khromy@lnuxlab.ath.cx (khromy) escribió:
> I just tried with my Promise UDMA100 card with another cable and same 
> problem.  Any other ideas? Should I try rc1-aa1?

Another interesting thing would be to re-format the slow-partition, to
ext3 or another filesystem(if this can be done because you can backup
all the data)
