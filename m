Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbTIUQmU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 12:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbTIUQmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 12:42:20 -0400
Received: from bolyai1.elte.hu ([157.181.72.1]:418 "EHLO bolyai1.elte.hu")
	by vger.kernel.org with ESMTP id S262451AbTIUQmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 12:42:18 -0400
Subject: Re: Loop device and smbmount: I/O error
From: Kovacs Gabor <kgabor@BOLYAI1.ELTE.HU>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F6B1FAF.89C9F5F4@pp.inet.fi>
References: <1063914356.1639.34.camel@warp>  <3F6B1FAF.89C9F5F4@pp.inet.fi>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Sep 2003 18:46:03 +0200
Message-Id: <1064162764.5217.5.camel@warp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-19 at 17:24, Jari Ruusu wrote:
> 
> This bug should be fixed in loop-AES version of loop, here:
> 
> http://loop-aes.sourceforge.net/loop-AES/loop-AES-v1.7e.tar.bz2
> 
> Can you try again with that version?

It works! (2.4.22 + loop-AES-v1.7e.tar.bz2)
Thanks!

Gabor Kovacs


