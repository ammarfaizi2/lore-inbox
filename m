Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317896AbSGVXCb>; Mon, 22 Jul 2002 19:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317898AbSGVXCb>; Mon, 22 Jul 2002 19:02:31 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:19954 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317896AbSGVXCa>; Mon, 22 Jul 2002 19:02:30 -0400
Subject: Re: [OOPS] 2.5.27 - __free_pages_ok()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Larson <plars@austin.ibm.com>
Cc: Rik van Riel <riel@conectiva.com.br>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, haveblue@us.ibm.com
In-Reply-To: <1027377273.5170.37.camel@plars.austin.ibm.com>
References: <Pine.LNX.4.44L.0207221704120.3086-100000@imladris.surriel.com>
	 <1027377273.5170.37.camel@plars.austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 23 Jul 2002 01:18:10 +0100
Message-Id: <1027383490.32299.94.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> and it still hung on boot, but kgcc is egcs-2.91.66 19990314/Linux
> (egcs-1.1.2 release).  If it would be helpful, I'll try compiling my
> kernel on a debian box tomorrow and booting with that.

egcs-1.1.2 does have real problems with 2.5

7.1 errata/7.2/7.3 gcc 2.96 appear quite happy

