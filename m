Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261797AbSIXVXj>; Tue, 24 Sep 2002 17:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261805AbSIXVXj>; Tue, 24 Sep 2002 17:23:39 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:11273 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S261797AbSIXVXi>; Tue, 24 Sep 2002 17:23:38 -0400
Message-Id: <200209242127.g8OLRTxN005667@pincoya.inf.utfsm.cl>
To: Larry Kessler <kessler@us.ibm.com>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       Hien Nguyen <hien@us.ibm.com>, James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: [evlog-dev] Re: alternate event logging proposal 
In-Reply-To: Message from Larry Kessler <kessler@us.ibm.com> 
   of "Tue, 24 Sep 2002 14:11:31 MST." <3D90D503.8F4CDEB6@us.ibm.com> 
Date: Tue, 24 Sep 2002 17:27:29 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry Kessler <kessler@us.ibm.com> said:

[...]

> Event logging uses real-time signaling to notify a process that's registered
> for notification that an event matching the criteria defined during 
> registration has been written to the event log.  When notified, the process
> can read the entire event from the event log and then do whatever.

How is said event found? By scanning the whole log?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
