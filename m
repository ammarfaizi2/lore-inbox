Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263232AbTCNDlC>; Thu, 13 Mar 2003 22:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263234AbTCNDlC>; Thu, 13 Mar 2003 22:41:02 -0500
Received: from packet.digeo.com ([12.110.80.53]:5610 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263232AbTCNDlC>;
	Thu, 13 Mar 2003 22:41:02 -0500
Date: Thu, 13 Mar 2003 19:51:49 -0800
From: Andrew Morton <akpm@digeo.com>
To: Shawn <core@enodev.com>
Cc: elenstev@mesatop.com, jeremy@goop.org, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.64-mm6
Message-Id: <20030313195149.55b517c7.akpm@digeo.com>
In-Reply-To: <1047613609.2848.3.camel@localhost.localdomain>
References: <20030313032615.7ca491d6.akpm@digeo.com>
	<1047572586.1281.1.camel@ixodes.goop.org>
	<20030313113448.595c6119.akpm@digeo.com>
	<1047611104.14782.5410.camel@spc1.mesatop.com>
	<20030313192809.17301709.akpm@digeo.com>
	<1047613609.2848.3.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Mar 2003 03:51:43.0168 (UTC) FILETIME=[06D85400:01C2E9DD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn <core@enodev.com> wrote:
>
> Being an active user of the 2.5 series including -mm, should I have
> updated glibc, or is there nothing new enough yet to warrant that?

I think so, yes.  There is the threading support and also the new
sysenter system-call entry code.

