Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261586AbSJDMqm>; Fri, 4 Oct 2002 08:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261587AbSJDMqm>; Fri, 4 Oct 2002 08:46:42 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:30711 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261586AbSJDMql>; Fri, 4 Oct 2002 08:46:41 -0400
Subject: Re: export of sys_call_table
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: bidulock@openss7.org
Cc: Arjan van de Ven <arjanv@fenrus.demon.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021004051932.A13743@openss7.org>
References: <20021003153943.E22418@openss7.org>
	<1033682560.28850.32.camel@irongate.swansea.linux.org.uk>
	<20021003170608.A30759@openss7.org>
	<1033722612.1853.1.camel@localhost.localdomain> 
	<20021004051932.A13743@openss7.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Oct 2002 14:00:31 +0100
Message-Id: <1033736431.31839.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Which ends up looking suspiciously like an overcomplicated way to
implement "ioctl", and wrap the message stuff up as ioctls. Getting
getmsg/putmsg loadable interfaces right looks a good thing for 2.5
though

