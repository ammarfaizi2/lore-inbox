Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbTHYWKf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 18:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbTHYWKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 18:10:35 -0400
Received: from modemcable009.53-202-24.mtl.mc.videotron.ca ([24.202.53.9]:51075
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262296AbTHYWKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 18:10:30 -0400
Date: Mon, 25 Aug 2003 18:09:17 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "J.A. Magallon" <jamagallon@able.es>
cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OT] sizeof C types ...
In-Reply-To: <20030825211950.GC3346@werewolf.able.es>
Message-ID: <Pine.LNX.4.53.0308251807100.31503@montezuma.fsmlabs.com>
References: <20030825191339.GA28525@www.13thfloor.at> <20030825202721.A10828@infradead.org>
 <20030825211950.GC3346@werewolf.able.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Aug 2003, J.A. Magallon wrote:

> If you don't go away from linux, OK.
> 
> Really:
> char = 8bit
> long int = 32 or 64, depending on arch

Well then you can argue that 'long int' is 32bit on 64bit platforms on 
Windows (the Windows API dictates LLP64) </pedantry>

> long long = 64 bits
> 
> int = ??? almost anything, depending on arch and compiler.
> Run DOS on your P4, with an old compiler, and int defaults to 16 bits.
> I think the same also happens for Win16.
> 
> int is defined ad the native word size of the hardware+OS.
