Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262369AbTCMOSG>; Thu, 13 Mar 2003 09:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262370AbTCMOSG>; Thu, 13 Mar 2003 09:18:06 -0500
Received: from pusa.informat.uv.es ([147.156.10.98]:38857 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP
	id <S262369AbTCMOSF>; Thu, 13 Mar 2003 09:18:05 -0500
Date: Thu, 13 Mar 2003 15:28:44 +0100
To: Srihari Vijayaraghavan <harisri@bigpond.com>
Cc: linux-kernel@vger.kernel.org
Subject: OFFTOPIC: Re: Request for help - tcpdump on many ethernet cards simulateneously
Message-ID: <20030313142844.GA22679@pusa.informat.uv.es>
References: <200303140051.19453.harisri@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200303140051.19453.harisri@bigpond.com>
User-Agent: Mutt/1.3.28i
From: uaca@alumni.uv.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2003 at 12:51:19AM +1100, Srihari Vijayaraghavan wrote:
[...]
> What I am really worried about is kernel may start dropping the packets after 
> few hours/days and/or tcpdump/kernel may not be able to keep up with the 
> network load due to IO load on the hard drives, memory pressure etc.. 

find a libpcap using CONFIG_PACKET_MMAP, and you will probably forget about
drops IMHO

if you do find it, please let me now

I'm currently using pandora's monitor modified libpcap.... GREAT

I think that Linux is the only OS that provides user space buffers to packet
capture... am I wrong?

Maybe this is an offtopic on this mailing list... 
...so this is my first and last mail about it here.

	Ulisses

                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociación Valenciana de Usuarios de Linux		<---
 
