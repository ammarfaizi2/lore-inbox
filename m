Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313882AbSDIMXc>; Tue, 9 Apr 2002 08:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313883AbSDIMXb>; Tue, 9 Apr 2002 08:23:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47036 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S313882AbSDIMXa>;
	Tue, 9 Apr 2002 08:23:30 -0400
Date: Tue, 09 Apr 2002 05:15:45 -0700 (PDT)
Message-Id: <20020409.051545.78788265.davem@redhat.com>
To: paulus@samba.org
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SET_PERSONALITY for static executables
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15538.55862.174959.115786@argo.ozlabs.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Paul Mackerras <paulus@samba.org>
   Date: Tue, 9 Apr 2002 22:10:30 +1000 (EST)
   
   The SET_PERSONALITY call which made a brief appearance in 2.4.18-rc4
   (setting the personality for static binaries in fs/binfmt_elf.c) still
   hasn't reappeared as of 2.4.19-pre6.  Here is the patch to put it back
   in.

It's there in his current tree, where are you looking?
