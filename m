Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291159AbSBLQHb>; Tue, 12 Feb 2002 11:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290276AbSBLQHW>; Tue, 12 Feb 2002 11:07:22 -0500
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:50353 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S291159AbSBLQG5>; Tue, 12 Feb 2002 11:06:57 -0500
Subject: nm256_audio.o
From: NyQuist <NyQuist@ntlworld.com>
To: Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 12 Feb 2002 16:02:15 +0000
Message-Id: <1013529735.9204.23.camel@stinky.pussy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I've a problem with this module. For some reason it locks up my laptop
when modprobed. I'm running redhat's 2.4.7-10 on an i686 and i'm using
the neomagic 256 chipset which I believe is a graphics/sound combination
(with 4 meg or so of mem), the comp is a dell latitude ls.
The card does work, as it runs under the commercial oss drivers, thing
is because the machine locks tight running the kernel 256_audio, I can't
get any debug information, the machine has to be physically
unplugged/debatteried (lucky I run ext3 :) Not even a messages error. 
Anyone with any info? I'm gonna have a look and try to debug, but i'm no
kernel hacker.
Thks
-- 
NyQuist | Matthew Hall -- NyQuist at ntlworld dot com 
Sig: Microsoft sells you Windows. Linux gives you the whole house.

