Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbSJJSeA>; Thu, 10 Oct 2002 14:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbSJJSd7>; Thu, 10 Oct 2002 14:33:59 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63493 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261955AbSJJSd6>; Thu, 10 Oct 2002 14:33:58 -0400
Date: Thu, 10 Oct 2002 11:38:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, <johnstul@us.ibm.com>
Subject: Re: [BK PATCH] i386 timer changes for 2.5.41
In-Reply-To: <Pine.LNX.4.44.0210101132300.4124-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0210101137310.4124-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I ended up just importing it from the patches I had pending anyway. 
Including the Cyclone code, although I removed the Config.in entry to make 
sure nobody even tries to enable it until the rest of the summit code is 
there.

		Linus

