Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135198AbRD3MAz>; Mon, 30 Apr 2001 08:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135209AbRD3MAq>; Mon, 30 Apr 2001 08:00:46 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:32519 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S135198AbRD3MAb>;
	Mon, 30 Apr 2001 08:00:31 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Olaf Stetzer <ostetzer@mail.uni-mainz.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: make bzlilo seems to ignore non-standard kernel path in lilo.conf (/boot) 
In-Reply-To: Your message of "Mon, 30 Apr 2001 12:16:24 +0200."
             <01043012162401.00851@Seaborg> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 30 Apr 2001 22:00:23 +1000
Message-ID: <12019.988632023@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2001 12:16:24 +0200, 
Olaf Stetzer <ostetzer@mail.uni-mainz.de> wrote:
>when I tried to get rid of the problem I wrote about two days ago in 
>this list I compiled the kernel several times but unfortunately it was
>not installed correctly by the make target bzlilo.

make INSTALL_PATH=/boot bzlilo

