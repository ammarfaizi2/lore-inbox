Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269533AbTCDT51>; Tue, 4 Mar 2003 14:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269534AbTCDT51>; Tue, 4 Mar 2003 14:57:27 -0500
Received: from pusa.informat.uv.es ([147.156.10.98]:16283 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP
	id <S269533AbTCDT50>; Tue, 4 Mar 2003 14:57:26 -0500
Date: Tue, 4 Mar 2003 21:07:44 +0100
To: Vergoz Michael <mvergoz@sysdoor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 'cooked' packets
Message-ID: <20030304200744.GA20975@pusa.informat.uv.es>
References: <3E6504FA.2090707@sysdoor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E6504FA.2090707@sysdoor.com>
User-Agent: Mutt/1.3.28i
From: uaca@alumni.uv.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 08:56:42PM +0100, Vergoz Michael wrote:
> Hi list,
> 
> I want to know, why Linux have a "cooked" packets capture encapsulation 
> ??@#!

Take a look at pcap-linux.c (libpcap library)

this is not a pure kernel issue, probably you should ask to linux-net mailing
list

	Ulisses
                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociación Valenciana de Usuarios de Linux		<---
 
