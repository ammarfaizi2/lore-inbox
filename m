Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316705AbSHOKzk>; Thu, 15 Aug 2002 06:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316728AbSHOKzk>; Thu, 15 Aug 2002 06:55:40 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:20987 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316705AbSHOKzj>; Thu, 15 Aug 2002 06:55:39 -0400
Subject: Re: [ANNOUNCE] New PC-Speaker driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Phillips <phillips@arcor.de>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, Andrew Rodland <arodland@noln.com>,
       Stas Sergeev <stssppnn@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E17fI5E-0002at-00@starship>
References: <3D5A8C2C.9010700@yahoo.com>
	<20020814184407.4ca9e406.arodland@noln.com>
	<200208150821.g7F8L6p19730@Port.imtp.ilyichevsk.odessa.ua> 
	<E17fI5E-0002at-00@starship>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 15 Aug 2002 11:57:31 +0100
Message-Id: <1029409051.29816.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are easier equivalent ways to accurately measure the IRQ
behaviour. Flip the state of a parallel port pin when you mask
interrupts. You can even slap an oscilloscope on it that way

