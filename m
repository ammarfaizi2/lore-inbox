Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261429AbSJVPRJ>; Tue, 22 Oct 2002 11:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262813AbSJVPRJ>; Tue, 22 Oct 2002 11:17:09 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:27577 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261429AbSJVPRH>; Tue, 22 Oct 2002 11:17:07 -0400
Subject: Re: running 2.4.2 kernel under 4MB Ram
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Amol Kumar Lad <amolk@ishoni.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <1035333109.2200.2.camel@amol.in.ishoni.com>
References: <1035281203.31873.34.camel@irongate.swansea.linux.org.uk> 
	<1035333109.2200.2.camel@amol.in.ishoni.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 16:39:24 +0100
Message-Id: <1035301164.31917.78.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 01:31, Amol Kumar Lad wrote:
> It means that I _cannot_ run 2.4.2 on a 4MB box. 
> Actually my embedded system already has 2.4.2 running on a 16Mb. I was
> looking for a way to run it in 4Mb. 
> So Is upgrade to 2.4.19 the only option ??

You should move to a later kernel anyway 2.4.2 has a lot of bugs
including some security ones.

