Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314282AbSEFIVm>; Mon, 6 May 2002 04:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314283AbSEFIVl>; Mon, 6 May 2002 04:21:41 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:55478 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S314282AbSEFIVe>; Mon, 6 May 2002 04:21:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Ivan G." <ivangurdiev@linuxfreemail.com>
Reply-To: ivangurdiev@linuxfreemail.com
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5 keyboard timeout
Date: Mon, 6 May 2002 02:14:45 -0600
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02050602144500.00976@cobra.linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

May  6 01:49:51 cobra kernel: keyboard: Timeout - AT keyboard not present?(ed)
problem exists for both 2.5.13 and 2.5.14 ( i wasn't able to get earlier 
kernels to work)

When X boots, the mouse works. Mouse freezes on attempt to type anything with 
the keyboard. Single - user mode: keyboard is dead by the time I need to type 
the root password.

Keyboard works fine with 2.4 kernels 









