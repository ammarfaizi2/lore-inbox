Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143432AbRELAKt>; Fri, 11 May 2001 20:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143425AbRELAKj>; Fri, 11 May 2001 20:10:39 -0400
Received: from h55p103-2.delphi.afb.lu.se ([130.235.187.175]:2531 "EHLO gin")
	by vger.kernel.org with ESMTP id <S143431AbRELAK1>;
	Fri, 11 May 2001 20:10:27 -0400
Date: Sat, 12 May 2001 02:13:51 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac8 now with added correct EXTRAVERSION
Message-ID: <20010512021351.A784@h55p111.delphi.afb.lu.se>
In-Reply-To: <E14yJEw-0001dW-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <E14yJEw-0001dW-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, May 11, 2001 at 09:10:17PM +0100
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somewhere between ac5 and ac8 ipc broke, noticed that fakeroot stopped
working, getting a function not implemented in msgget:

[pid  9812] msgget(667493921, IPC_CREAT|0x180|0600) = -1 ENOSYS (Function not implemented)

ac5 works, ac8 does not.. downloading ac6 and 7 now to see exactly where it broke.

-- 

//anders/g

