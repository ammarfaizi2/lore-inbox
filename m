Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265544AbSKABV3>; Thu, 31 Oct 2002 20:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265576AbSKABV3>; Thu, 31 Oct 2002 20:21:29 -0500
Received: from packet.digeo.com ([12.110.80.53]:26620 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265571AbSKABVN>;
	Thu, 31 Oct 2002 20:21:13 -0500
Message-ID: <3DC1D884.8168D9C3@digeo.com>
Date: Thu, 31 Oct 2002 17:27:32 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>,
       "Dieter =?iso-8859-1?Q?N=FCtzel?=" <Dieter.Nuetzel@hamburg.de>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Reiserfs-List@namesys.com,
       Oleg Drokin <green@namesys.com>, zam@namesys.com,
       umka <umka@thebsh.namesys.com>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
References: <3DC19F61.5040007@namesys.com> <200210312334.18146.Dieter.Nuetzel@hamburg.de> <3DC1B2FA.8010809@namesys.com> <3DC1D63A.CCAD78EF@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Nov 2002 01:27:33.0306 (UTC) FILETIME=[DA2F61A0:01C28145]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> ...
> (The 2x-3x is on an 8meg filesystem.  Larger filesystems should
> gain more)

s/meg/gig/
