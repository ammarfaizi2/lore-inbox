Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315419AbSEYV5t>; Sat, 25 May 2002 17:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315421AbSEYV5s>; Sat, 25 May 2002 17:57:48 -0400
Received: from iris.duna.pl ([217.98.70.4]:61571 "EHLO darkstar.avalon.land")
	by vger.kernel.org with ESMTP id <S315419AbSEYV5r>;
	Sat, 25 May 2002 17:57:47 -0400
Date: Sat, 25 May 2002 23:56:03 +0200
From: =?iso-8859-2?Q?Justyna_Bia=B3a?= <nell@poczta.gazeta.pl>
To: linux-kernel@vger.kernel.org
Subject: framebuffer problem with 2.4.19-pre8-ac5 and Radeon VE
Message-ID: <20020525235602.A666@poczta.gazeta.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have Radeon VE and I have tried to run framebuffer with Alan's
version of kernel: 2.4.19-pre8-ac5. Unfortunately it doesn't work fine for me:
I have very bad refresh, the consoles are switched with change of display mode.
The cursor is coloured and has different colours on each console and so on.  
I had the same problems wth the kernels 2.4.18 and 2.4.19-preX untill I found
the patch made by Peter Horton (posted on this list). With this patch I had
good support of framebuffer in any kernel from 2.4.19-pre2 up. I was hoping,
that latest -ac branch kernel have this patch included but it seems not.  
With Peter's patch my card and framebuffer works fine while with -ac kernel it
doesn't.

Greets

nell

-- 
eounicorn - Escape of the Unicorn
Free 2D flying shooter game -- http://eounicorn.sourceforge.net
