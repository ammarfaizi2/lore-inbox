Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267268AbTA1O44>; Tue, 28 Jan 2003 09:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266720AbTA1O4z>; Tue, 28 Jan 2003 09:56:55 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:37505
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S267268AbTA1O4z>; Tue, 28 Jan 2003 09:56:55 -0500
Subject: Re: Bootscreen
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jos Hulzink <josh@stack.nl>
Cc: Wichert Akkerman <wichert@wiggy.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030128153533.X28781-100000@snail.stack.nl>
References: <Pine.LNX.4.44.0301281113480.20283-100000@schubert.rdns.com>
	 <200301281144.h0SBi0ld000233@darkstar.example.net>
	 <20030128114840.GV4868@wiggy.net>
	 <1043758528.8100.35.camel@dhcp22.swansea.linux.org.uk>
	 <20030128130953.GW4868@wiggy.net>
	 <1043761632.1316.67.camel@dhcp22.swansea.linux.org.uk>
	 <20030128143235.GY4868@wiggy.net>
	 <20030128153533.X28781-100000@snail.stack.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043766333.8798.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 28 Jan 2003 15:05:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-28 at 14:45, Jos Hulzink wrote:
> Oh, and using modules is a (minor) security issue. I have all my drivers
> compiled in the kernel. I like it and it is secure.

Myth I am afraid. Code for loading modules into a kernel with no module support
by poking in /dev/*mem exists and is published. 

