Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316130AbSETQxO>; Mon, 20 May 2002 12:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316134AbSETQxN>; Mon, 20 May 2002 12:53:13 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:40716 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id <S316130AbSETQxN>; Mon, 20 May 2002 12:53:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Henrique Gobbi <henrique@cyclades.com>
Reply-To: henrique@cyclades.com
Organization: Cyclades Corporation
To: <linux-kernel@vger.kernel.org>
Subject: FIB: Insertion of a route
Date: Mon, 20 May 2002 13:55:42 -0300
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02052013554203.00840@henrique.cyclades.com.br>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all !!!

My last e-mail was a sort of confused so I'm gonna try again:

I am implementing (or trying to) inverseARP for frame-relay. Every thing goes 
ok until the time I have to insert a new route on the Route Table of the 
kernel.

I have a struct device and the destination address. What I have to do to add 
the new route to the system from the kernel-space.

thanks in advance
Henrique
