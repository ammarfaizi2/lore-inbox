Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319169AbSIDMod>; Wed, 4 Sep 2002 08:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319170AbSIDMod>; Wed, 4 Sep 2002 08:44:33 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:10484
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319169AbSIDMoc>; Wed, 4 Sep 2002 08:44:32 -0400
Subject: Re:  writing OOPS/panic info to nvram?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: morten.helgesen@nextframe.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020904143115.A117@sexything>
References: <200209041350.21358.roy@karlsbakk.net>
	<1031142093.2796.116.camel@irongate.swansea.linux.org.uk> 
	<20020904143115.A117@sexything>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 04 Sep 2002 13:49:12 +0100
Message-Id: <1031143752.2788.118.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-04 at 13:31, Morten Helgesen wrote:
> True - the 'normal' size on a PC is apparently something like 114 bytes ... 
> I  guess we could use it for something useful ... but maybe not for
> OOPSen/panics. 
> 
> I didn`t realize we only had 114 bytes to work with.

We don't. They are all used by the BIOS

