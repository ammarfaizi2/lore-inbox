Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265525AbSJSGA3>; Sat, 19 Oct 2002 02:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265526AbSJSGA3>; Sat, 19 Oct 2002 02:00:29 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15823 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265525AbSJSGA3>;
	Sat, 19 Oct 2002 02:00:29 -0400
Date: Fri, 18 Oct 2002 22:58:48 -0700 (PDT)
Message-Id: <20021018.225848.25861067.davem@redhat.com>
To: atai@atai.org, lichengtai@yahoo.com
Cc: linux-kernel@vger.kernel.org, greearb@candelatech.com
Subject: Re: Tigon3 driver problem with raw socket on 2.4.20-pre10-ac2
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021019060221.92006.qmail@web10504.mail.yahoo.com>
References: <20021017.231249.14334285.davem@redhat.com>
	<20021019060221.92006.qmail@web10504.mail.yahoo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andy Tai <lichengtai@yahoo.com>
   Date: Fri, 18 Oct 2002 23:02:21 -0700 (PDT)

   Thanks for your sugestion.  With Linux 2.4.19, the
   problem goes away.  So something is wrong with the
   2.4.20-pre kernels as related to the AMD Athlon...
   
To be honest, I have had a few relaibly reocurring lockups of my
Athlon at night.

I tend not to mention them however, because this machine has an AGP
graphics card where I've removed the brace that keep it in the AGP
slot, so it tends to slide out when it gets warm due to lots of 3d
rendering.... :-)
