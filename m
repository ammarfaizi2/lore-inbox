Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262689AbSJLJIQ>; Sat, 12 Oct 2002 05:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262842AbSJLJIQ>; Sat, 12 Oct 2002 05:08:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48515 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262689AbSJLJIP>;
	Sat, 12 Oct 2002 05:08:15 -0400
Date: Sat, 12 Oct 2002 02:07:14 -0700 (PDT)
Message-Id: <20021012.020714.31750647.davem@redhat.com>
To: rmk@arm.linux.org.uk
Cc: dilinger@mp3revolution.net, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] sparc64 makefile dep fix for uart_console_init
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021012095348.A12955@flint.arm.linux.org.uk>
References: <20021012082405.GB10000@chunk.voxel.net>
	<20021012.013507.27779687.davem@redhat.com>
	<20021012095348.A12955@flint.arm.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Russell King <rmk@arm.linux.org.uk>
   Date: Sat, 12 Oct 2002 09:53:48 +0100

   On Sat, Oct 12, 2002 at 01:35:07AM -0700, David S. Miller wrote:
   > Probably a fix could be to add CONFIG_SERIAL_SUNCORE to the
   > checks that set CONFIG_SERIAL_CORE, I think that's how I'll
   > fix this.
   
   Agreed.  Do you want me to make the change?

Yes, please do.
