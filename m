Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318729AbSHQURS>; Sat, 17 Aug 2002 16:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318730AbSHQURS>; Sat, 17 Aug 2002 16:17:18 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:38898 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318729AbSHQURR>; Sat, 17 Aug 2002 16:17:17 -0400
Subject: Re: Results with 2.4.20-pre2-ac3 and alim15x3 driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Art Haas <ahaas@neosoft.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020816161323.GA421@debian>
References: <20020816161323.GA421@debian>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 17 Aug 2002 21:20:40 +0100
Message-Id: <1029615640.4809.65.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-16 at 17:13, Art Haas wrote:

> The latest -ac release is the first in a while that I've been
> able to boot without having to use "ide=nodma". I've yet to find
> the magic flag in the BIOS configuration (or wherever it's located)
> that will activate DMA for this machine. When booting off earlier

I don't totally trust the DMA off logic in the current tree. I think its
over pessimal. Thats a pending item to investigate.

