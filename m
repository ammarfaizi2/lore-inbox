Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbTH0Btj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 21:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbTH0Btj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 21:49:39 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:31707 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263021AbTH0Bsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 21:48:37 -0400
Message-ID: <3F4C0DDD.9040402@comcast.net>
Date: Tue, 26 Aug 2003 21:48:13 -0400
From: David van Hoose <david.vanhoose@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: campbell@accelinc.com
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.22 released
References: <200308251148.h7PBmU8B027700@hera.kernel.org> <20030825132358.GC14108@merlin.emma.line.org> <1061818535.1175.27.camel@debian> <20030825211307.GA3346@werewolf.able.es> <20030825222215.GX7038@fs.tum.de> <1061857293.15168.3.camel@debian> <20030826234901.1726adec.aradorlinux@yahoo.es> <20030826215544.GI7038@fs.tum.de> <20030827012016.GA10502@helium.inexs.com>
In-Reply-To: <20030827012016.GA10502@helium.inexs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Campbell wrote:
> On Tue, Aug 26, 2003 at 11:55:44PM +0200, Adrian Bunk wrote:
> 
>>- it's easy to use ALSA even when it's not inside the kernel
> 
> please point me to a doc or a HOWTO to do this, and I'll be happy.

All you have to do is install the packages on alsa-project.org and just 
recompile the alsa-driver package everytime you compile a new kernel.
Be sure to be root when installing the ALSA stuff.

-David

