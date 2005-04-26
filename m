Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVDZRYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVDZRYP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 13:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVDZRWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 13:22:40 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:34613 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261690AbVDZRW1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 13:22:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=B95/mBJeh/HiTzyGVIcpWY6tVz5y4i8UETUoR6R7uqNKJsi6VvEXgn1CYjBorIO9iXhNaHrHc1JDgfBnd5VyNWtSpXwju39a6FwcAGJ6QisceWAUMq8mx9p+kk7WDVeHD+WM+1Uast6fXG30IwNGG39vbc80R6yHx5MHzPjJ+T4=
Date: Tue, 26 Apr 2005 19:22:20 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: john@stoffel.org, dedekind@oktetlabs.ru, v@iki.fi,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: filesystem transactions API
Message-Id: <20050426192220.4979de4d.diegocg@gmail.com>
In-Reply-To: <20050426152434.GB14297@mail.shareable.org>
References: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk>
	<OF32F95BBA.F38B2D1F-ON88256FEE.006FE841-88256FEE.00742E46@us.ibm.com>
	<20050426134629.GU16169@viasys.com>
	<20050426141426.GC10833@mail.shareable.org>
	<426E4EBD.6070104@oktetlabs.ru>
	<20050426143247.GF10833@mail.shareable.org>
	<17006.22498.394169.98413@smtp.charter.net>
	<20050426152434.GB14297@mail.shareable.org>
X-Mailer: Sylpheed version 1.9.9+svn (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 26 Apr 2005 16:24:34 +0100,
Jamie Lokier <jamie@shareable.org> escribió:

> It's even harder without kernel support! :)

This seems to implement something in userspace which might be interesting:
http://users.auriga.wearlab.de/~alb/libjio/
