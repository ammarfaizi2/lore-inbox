Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275399AbTHIUgk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 16:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275401AbTHIUgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 16:36:40 -0400
Received: from ALille-209-1-1-70.w80-11.abo.wanadoo.fr ([80.11.175.70]:39172
	"EHLO lenhof.homelinux.net") by vger.kernel.org with ESMTP
	id S275399AbTHIUgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 16:36:39 -0400
Subject: Re: kernel oops...
From: Jean-Yves LENHOF <jean-yves@lenhof.eu.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1060432742.620.17.camel@mydebian>
References: <1060432742.620.17.camel@mydebian>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1060461449.622.22.camel@mydebian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 09 Aug 2003 22:37:29 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le sam 09/08/2003 à 14:39, Jean-Yves LENHOF a écrit :
> Hello all,
> 
> I've just add two hangs with a plain vanilla kernel 2.4.21 on a Debian
> woody up2date. The machine is an old Pentium 100 with 64 Mb. Softs
> running on this machine are :

Seems the problem has gone by using the original Debian kernel 2.4.18...
Reading a little bit the different changelog of kernel between 2.4.18
and 2.4.21, it seems that there are some vm change incorporated (from
-aa)...but I'm not an expert at all.

Another thing is that the load is about 2 or 3...

I hope somebody will have an idea off what's going on...

Have fun,

Jean-Yves

PS : Please CC me as I'm not on the list

