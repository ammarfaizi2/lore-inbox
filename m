Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318087AbSGMBHc>; Fri, 12 Jul 2002 21:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318088AbSGMBHb>; Fri, 12 Jul 2002 21:07:31 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:29948 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318087AbSGMBHa>; Fri, 12 Jul 2002 21:07:30 -0400
Subject: Re: 64 bit netdev stats counter
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3D2F58A7.6CC58590@nortelnetworks.com>
References: <1026503694.26819.4.camel@dell_ss3.pdx.osdl.net>
	<Pine.GSO.4.33L.0207121628100.19313-100000@unix2.cc.ksu.edu> 
	<20020712.145835.91443486.davem@redhat.com>
	<1026516053.9958.33.camel@irongate.swansea.linux.org.uk> 
	<3D2F58A7.6CC58590@nortelnetworks.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Jul 2002 03:18:53 +0100
Message-Id: <1026526733.9958.67.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-12 at 23:31, Chris Friesen wrote:
> 
> Isn't this the same as 32-bit counters on a machine that doesn't do atomic
> 32-bit ops?  Although in that case you could only be 2^16 off...

Yes but we don't happen to have any of those I care about 8)

