Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293447AbSCOX57>; Fri, 15 Mar 2002 18:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293532AbSCOX5t>; Fri, 15 Mar 2002 18:57:49 -0500
Received: from pizda.ninka.net ([216.101.162.242]:65441 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293447AbSCOX5a>;
	Fri, 15 Mar 2002 18:57:30 -0500
Date: Fri, 15 Mar 2002 15:54:32 -0800 (PST)
Message-Id: <20020315.155432.32126270.davem@redhat.com>
To: davids@webmaster.com
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: RFC2385 (MD5 signature in TCP packets) support
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020315235352.AAA221@shell.webmaster.com@whenever>
In-Reply-To: <E16m1bl-000554-00@the-village.bc.nu>
	<20020315235352.AAA221@shell.webmaster.com@whenever>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Schwartz <davids@webmaster.com>
   Date: Fri, 15 Mar 2002 15:53:51 -0800
   
   	One factor that would go into that decision is whether the
   patch would have a chance at being accepted into the kernel

Hmmm... ignoring whether rfc2385 is stupid or not, don't
we have crypto issues if we put something using MD5 into the tree?
