Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270956AbRHOAID>; Tue, 14 Aug 2001 20:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270955AbRHOAHy>; Tue, 14 Aug 2001 20:07:54 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49541 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S270954AbRHOAHr>;
	Tue, 14 Aug 2001 20:07:47 -0400
Date: Tue, 14 Aug 2001 17:06:57 -0700 (PDT)
Message-Id: <20010814.170657.13774916.davem@redhat.com>
To: thockin@sun.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: poll change
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3B79BD9C.4BA3546@sun.com>
In-Reply-To: <3B79BA07.B57634FD@sun.com>
	<20010814.165320.77058794.davem@redhat.com>
	<3B79BD9C.4BA3546@sun.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tim Hockin <thockin@sun.com>
   Date: Tue, 14 Aug 2001 17:09:00 -0700

   But for an application that (imho) is poorly written but IS COMPLIANT, it
   fails.
   
   This program is compliant, if your ulimit -n is maxxed out at 1048576.

This program is stupid.

Later,
David S. Miller
davem@redhat.com
