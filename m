Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264939AbTAER4Q>; Sun, 5 Jan 2003 12:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbTAER4Q>; Sun, 5 Jan 2003 12:56:16 -0500
Received: from pusa.informat.uv.es ([147.156.10.98]:23992 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP
	id <S264939AbTAER4P>; Sun, 5 Jan 2003 12:56:15 -0500
Date: Sun, 5 Jan 2003 19:04:46 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.54-mm3
Message-ID: <20030105180446.GA20388@pusa.informat.uv.es>
References: <3E16A2B6.A741AE17@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E16A2B6.A741AE17@digeo.com>
User-Agent: Mutt/1.3.28i
From: uaca@alumni.uv.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2003 at 01:00:38AM -0800, Andrew Morton wrote:
> 
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.54/2.5.54-mm3/

It seems to me that the patch you pointed here doesn't include the latency
instrumentation.

Where it is the needed instrumentation to meassure it?

In http://www.zip.com.au/~akpm/linux/ the are no timepeg/intlat patches for
2.5...

> 
> Several patches here which fix pretty much the last source of long
> scheduling latency stalls in the core kernel - long-held page_table_lock
> during pagetable teardown.
> 
> The preemptible kernel now achieves around 500 microsecond worst-case
> latency on a 500MHz PIII (with a slow memory system).  This is about as

[...]

	Ulisses

                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociación Valenciana de Usuarios de Linux		<---
 
