Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318787AbSHLSFB>; Mon, 12 Aug 2002 14:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318791AbSHLSFB>; Mon, 12 Aug 2002 14:05:01 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:22766 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318787AbSHLSFA>; Mon, 12 Aug 2002 14:05:00 -0400
Subject: Re: [PATCH] 2.4.19 revert block_llseek behavior to standard
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Phil Auld <pauld@egenera.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020812135701.G27650@vienna.EGENERA.COM>
References: <20020812120659.B27650@vienna.EGENERA.COM>
	<1029169257.16424.176.camel@irongate.swansea.linux.org.uk>
	<20020812123632.E27650@vienna.EGENERA.COM>
	<1029172448.16424.178.camel@irongate.swansea.linux.org.uk> 
	<20020812135701.G27650@vienna.EGENERA.COM>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Aug 2002 19:06:06 +0100
Message-Id: <1029175566.16421.196.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-12 at 18:57, Phil Auld wrote
> > Did it work correctly - the answer I believe is - no it didnt.
> > 
> 
> Fair enough. The higher level fix is a band-aid over bugs in some of 
> the lower level drivers. 
> 
> Thanks for the info. I didn't think that patch would go anywhere,
> but it did help explain why the change. 

Do push it for 2.5 - there we have time to find out what it exposes

