Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262383AbSJEPpP>; Sat, 5 Oct 2002 11:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262384AbSJEPpM>; Sat, 5 Oct 2002 11:45:12 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:56573 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262383AbSJEPpL>; Sat, 5 Oct 2002 11:45:11 -0400
Subject: Re: IDE subsystem issues with 2.4.1[89] [REVISITED]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Costa <brblueser@uol.com.br>
Cc: Linux kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20021005114725.3af9c194.brblueser@uol.com.br>
References: <20021005114725.3af9c194.brblueser@uol.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Oct 2002 16:59:39 +0100
Message-Id: <1033833579.4103.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-05 at 14:47, Andre Costa wrote:
> I know this is a known issue, and you guys are working on it; I also
> know many changes to IDE subsystem have been backported from 2.5.x
> series, and 2.4.20pre* already reflect some (all?) of them. I don't want
> to rush things, I was just curious to know the current status regarding
> these IDE issues.

2.5 has most but not all of the IDE updates in 2.4-ac. 2.4 vanilla has
basically old IDE code but with some small PCI layer fixes backported
that deal with all the i845G bios mess


