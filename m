Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312846AbSCZXmK>; Tue, 26 Mar 2002 18:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312792AbSCZXmA>; Tue, 26 Mar 2002 18:42:00 -0500
Received: from pizda.ninka.net ([216.101.162.242]:24225 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312846AbSCZXlq>;
	Tue, 26 Mar 2002 18:41:46 -0500
Date: Tue, 26 Mar 2002 15:37:06 -0800 (PST)
Message-Id: <20020326.153706.110393494.davem@redhat.com>
To: davej@suse.de
Cc: greearb@candelatech.com, linux-kernel@vger.kernel.org
Subject: Re: up-to-date bk repository?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020327003000.C7501@suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dave Jones <davej@suse.de>
   Date: Wed, 27 Mar 2002 00:30:00 +0100

   On Tue, Mar 26, 2002 at 03:11:04PM -0800, David S. Miller wrote:
    > 
    > echo -n >include/asm-i386/proc_fs.h
   
   *blink* asm specific proc_fs stuff ?
   
   s/asm/linux/ in the #include surely ?

See the PPC64 stuff that got added:

	bk revtool fs/proc/root.c

