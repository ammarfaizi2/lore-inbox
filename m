Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293337AbSD1LlB>; Sun, 28 Apr 2002 07:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293458AbSD1LlA>; Sun, 28 Apr 2002 07:41:00 -0400
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:44515 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S293337AbSD1LlA>; Sun, 28 Apr 2002 07:41:00 -0400
Subject: Re: 2.5.10-dj1: i2c-parport.c:23: linux/i2c-old.h: No such file or
	directory
From: Philip Blundell <philb@gnu.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-i2c@pelican.tk.uni-linz.ac.at, kraxel@bytesex.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.NEB.4.44.0204281321560.3103-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 28 Apr 2002 13:41:05 +0100
Message-Id: <1019997665.433.13.camel@kc>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-04-28 at 12:25, Adrian Bunk wrote:
> while trying to compile kernel 2.5.10-dj1 the compilation of i2c-parport.c
> failed with the following error message:

I think i2c-parport.c should be pulled from the kernel.  It is obsoleted
by i2c-philips-par.c.

p

