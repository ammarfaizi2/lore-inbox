Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318946AbSHAMdm>; Thu, 1 Aug 2002 08:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318951AbSHAMdm>; Thu, 1 Aug 2002 08:33:42 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:63214 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318946AbSHAMdl>; Thu, 1 Aug 2002 08:33:41 -0400
Subject: Re: Linux v2.4.19-rc5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Willy TARREAU <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020801113205.GA9532@pcw.home.local>
References: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva> 
	<20020801113205.GA9532@pcw.home.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Aug 2002 14:54:04 +0100
Message-Id: <1028210044.15022.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-01 at 12:32, Willy TARREAU wrote:
> Hi Marcello,
> 
> This is just a cleanup for the network devices configuration.
> Basically, the TOSHIBA TC35815 configuration entry appears
> just between DECchip Tulip, and the 2 Tulip-specific config lines
> which are indented so we could think that they are related to
> the TC35815 instead of the Tulip.

This is true, but the fix wants tweaking - the file is supposed to bein
basically Alphabetical order. Can you move the toshiba one down instead
?


