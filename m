Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262743AbRE0EMQ>; Sun, 27 May 2001 00:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262742AbRE0EMG>; Sun, 27 May 2001 00:12:06 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:49413 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262738AbRE0ELu>;
	Sun, 27 May 2001 00:11:50 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Rene <kaos@intet.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 + ReiserFS + SMP + umount = oops 
In-Reply-To: Your message of "Sun, 27 May 2001 06:04:28 +0200."
             <Pine.LNX.4.21.0105270600300.21127-100000@virkelig.intet> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 27 May 2001 14:11:45 +1000
Message-ID: <30785.990936705@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 May 2001 06:04:28 +0200 (CEST), 
Rene <kaos@intet.dk> wrote:
>hmm I feel quite certain that I am using /dev/tty - is there some way I
>can check this?

/etc/inittab, lines for mingetty, getty or agetty.

