Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267386AbSLEUdK>; Thu, 5 Dec 2002 15:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267387AbSLEUdK>; Thu, 5 Dec 2002 15:33:10 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:35076 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267386AbSLEUdJ>; Thu, 5 Dec 2002 15:33:09 -0500
Date: Thu, 5 Dec 2002 20:40:42 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Samium Gromoff <deepfire@ibe.miee.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.50] Keyboard dying
In-Reply-To: <200212051456.gB5Eusbv000881@ibe.miee.ru>
Message-ID: <Pine.LNX.4.44.0212052039560.31967-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>        After some X <-> back switches keyboard stops doing anything.
>        2.5.50 + preempt enabled, X 4.2.1-debian-unstable.
> 
> showkey started using gpm tells that the keys actually are pressed and
> processed by the kernel.
> Although even alt+sysrq+whatever do not make any effect.

Can you disable preempt and see if you have the same problem.
 

