Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSG3SoF>; Tue, 30 Jul 2002 14:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315456AbSG3SoF>; Tue, 30 Jul 2002 14:44:05 -0400
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:54206
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S315454AbSG3SoE>; Tue, 30 Jul 2002 14:44:04 -0400
Date: Tue, 30 Jul 2002 14:47:10 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Remco Treffkorn <remco@rvt.com>
cc: "David S. Miller" <davem@redhat.com>, <dan@embeddededge.com>,
       <benh@kernel.crashing.org>, <trini@kernel.crashing.org>,
       <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>,
       <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 3 Serial issues up for discussion
In-Reply-To: <200207301123.48322.remco@rvt.com>
Message-ID: <Pine.LNX.4.44.0207301444070.32681-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2002, Remco Treffkorn wrote:

> Is the overhead in getting a minor acceptable?

Come on!  Is actually getting a minor for your serial ports, which only 
happens at registration time, a really big bottleneck on your system?


Nicolas

