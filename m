Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265998AbSKDNOa>; Mon, 4 Nov 2002 08:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265997AbSKDNOa>; Mon, 4 Nov 2002 08:14:30 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:2704 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265995AbSKDNO3>; Mon, 4 Nov 2002 08:14:29 -0500
Subject: Re: idle=poll needed??
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Reed, Timothy A" <timothy.a.reed@lmco.com>
Cc: Linux "Kernel ML (E-mail)" <linux-kernel@vger.kernel.org>
In-Reply-To: <9EFD49E2FB59D411AABA0008C7E675C00DCDFC48@emss04m10.ems.lmco.com>
References: <9EFD49E2FB59D411AABA0008C7E675C00DCDFC48@emss04m10.ems.lmco.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Nov 2002 13:42:43 +0000
Message-Id: <1036417363.1106.38.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-04 at 12:51, Reed, Timothy A wrote:
> All,
> 	We currently have setup, Dual P4-Xeon 2.2G machines running 2.4.19,
> with 2GB of RAM.
> 	Is there any performance reasons to keep the idle=poll in the append
> line?  I have not seen any degraded performance with the option, but some of
> our subs are having performance issues with it in.

It actually depends on what you are doing whether it has any impact.
Also of course if power use is a consideration

