Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261672AbSJIA7F>; Tue, 8 Oct 2002 20:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261673AbSJIA5v>; Tue, 8 Oct 2002 20:57:51 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61865 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261672AbSJIA4w>;
	Tue, 8 Oct 2002 20:56:52 -0400
Date: Tue, 08 Oct 2002 17:55:27 -0700 (PDT)
Message-Id: <20021008.175527.60924962.davem@redhat.com>
To: jchua@fedex.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug 2 cpus shows as 4 cpus
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.42.0210090733280.367-100000@silk.corp.fedex.com>
References: <Pine.LNX.4.42.0210090733280.367-100000@silk.corp.fedex.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Chua <jchua@fedex.com>
   Date: Wed, 9 Oct 2002 07:39:37 +0800 (SGT)

   flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
   cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm

Flag "ht" HyperThreading is set, that is why it looks like
4 processors instead of two.
