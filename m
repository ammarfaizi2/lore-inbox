Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311670AbSDIVab>; Tue, 9 Apr 2002 17:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311701AbSDIVaa>; Tue, 9 Apr 2002 17:30:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41921 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S311670AbSDIVa3>;
	Tue, 9 Apr 2002 17:30:29 -0400
Date: Tue, 09 Apr 2002 14:23:29 -0700 (PDT)
Message-Id: <20020409.142329.55241651.davem@redhat.com>
To: jurgen@pophost.eunet.be
Cc: linux-kernel@vger.kernel.org
Subject: Re: arch/sparc64/kernel/traps.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020409212000.GK9996@sparkie.is.traumatized.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jurgen Philippaerts <jurgen@pophost.eunet.be>
   Date: Tue, 9 Apr 2002 23:20:00 +0200

   TSTATE: 0000009911009601 TPC: 00000000005a39c0 TNPC: 00000000005a39c4
   Y: 00000000    Not tainted

Please send this through ksymoops so that we get the kernel
symbols that match up to all these magic numbers in your OOPS.
