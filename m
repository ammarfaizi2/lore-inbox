Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312169AbSDIXE7>; Tue, 9 Apr 2002 19:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312178AbSDIXE6>; Tue, 9 Apr 2002 19:04:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30146 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312169AbSDIXE6>;
	Tue, 9 Apr 2002 19:04:58 -0400
Date: Tue, 09 Apr 2002 15:57:57 -0700 (PDT)
Message-Id: <20020409.155757.34666328.davem@redhat.com>
To: jurgen@pophost.eunet.be
Cc: linux-kernel@vger.kernel.org
Subject: Re: arch/sparc64/kernel/traps.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020409214734.GL9996@sparkie.is.traumatized.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ksymoops should be already installed on your system
at /usr/bin/ksymoops, if it isn't find the package
to install or complain to your distribution maintainer :-)

If you still want to compile ksymoops from source you need to update
and install a new binutils to get the latest BFD library.
