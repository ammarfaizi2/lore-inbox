Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312792AbSCZXma>; Tue, 26 Mar 2002 18:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312848AbSCZXmV>; Tue, 26 Mar 2002 18:42:21 -0500
Received: from pizda.ninka.net ([216.101.162.242]:25505 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312792AbSCZXmL>;
	Tue, 26 Mar 2002 18:42:11 -0500
Date: Tue, 26 Mar 2002 15:37:30 -0800 (PST)
Message-Id: <20020326.153730.75726385.davem@redhat.com>
To: jgarzik@mandrakesoft.com
Cc: greearb@candelatech.com, linux-kernel@vger.kernel.org
Subject: Re: up-to-date bk repository?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3CA1044F.6020709@mandrakesoft.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@mandrakesoft.com>
   Date: Tue, 26 Mar 2002 18:29:19 -0500

   David S. Miller wrote:
   
   >echo -n >include/asm-i386/proc_fs.h
   >make
   >
   Carpel tunnel fans prefer  "> include/asm-i386/proc_fs.h"   :)
   
   removing asm/proc_fs.h include works too as a _temporary_ solution...
   
Well, that would break ppc64 :-)
