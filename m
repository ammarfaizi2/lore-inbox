Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314755AbSEDDTZ>; Fri, 3 May 2002 23:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315176AbSEDDTY>; Fri, 3 May 2002 23:19:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:42112 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314755AbSEDDTX>;
	Fri, 3 May 2002 23:19:23 -0400
Date: Fri, 03 May 2002 20:08:21 -0700 (PDT)
Message-Id: <20020503.200821.114659734.davem@redhat.com>
To: ward@db2adm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre8 syntax errors in fs/ufs/super.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0205032310200.21194-100000@roz.db2adm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ward Fenton <ward@db2adm.com>
   Date: Fri, 3 May 2002 23:15:10 -0400 (EDT)

   The following is a portion of the 2.4.19-pre8 patch with a correction
   for a few syntax errors.
   
   from patch-2.4.19-pre8
   missing commas in several added printk statements...
   
Yeah, I submitted this fix to Marcelo too.

These UFS changes that went into his tree weren't even build tested.
