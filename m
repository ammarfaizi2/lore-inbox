Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282441AbRKZTmb>; Mon, 26 Nov 2001 14:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282430AbRKZTlM>; Mon, 26 Nov 2001 14:41:12 -0500
Received: from pizda.ninka.net ([216.101.162.242]:27009 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S282428AbRKZTlC>;
	Mon, 26 Nov 2001 14:41:02 -0500
Date: Mon, 26 Nov 2001 11:40:45 -0800 (PST)
Message-Id: <20011126.114045.102135510.davem@redhat.com>
To: olh@suse.de
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] net/802/Makefile
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011126203527.C31937@suse.de>
In-Reply-To: <Pine.LNX.4.21.0111261514070.13961-100000@freak.distro.conectiva>
	<20011126.112033.88487539.davem@redhat.com>
	<20011126203527.C31937@suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Olaf Hering <olh@suse.de>
   Date: Mon, 26 Nov 2001 20:35:27 +0100

   Can you submit that version? ;)
   
No, because it is writable by the user in every kernel source tree I
have ever seen, the change makes no sense.

In the official tarballs it is writable, and even in every CVS tree
(2.2.x, 2.4.x vger) I have looked at it is writable.

And as Alan has stated, this code is pretty irrelevant soon.
