Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261177AbTCNWQU>; Fri, 14 Mar 2003 17:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261206AbTCNWQU>; Fri, 14 Mar 2003 17:16:20 -0500
Received: from packet.digeo.com ([12.110.80.53]:1672 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261177AbTCNWQT>;
	Fri, 14 Mar 2003 17:16:19 -0500
Date: Fri, 14 Mar 2003 14:21:39 -0800
From: Andrew Morton <akpm@digeo.com>
To: Eli Carter <eli.carter@inet.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.64-mm6
Message-Id: <20030314142139.675c994b.akpm@digeo.com>
In-Reply-To: <3E725156.5000102@inet.com>
References: <20030313032615.7ca491d6.akpm@digeo.com>
	<3E723DBF.6040304@inet.com>
	<20030314125354.409ca02a.akpm@digeo.com>
	<3E725156.5000102@inet.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Mar 2003 22:27:02.0076 (UTC) FILETIME=[D59F57C0:01C2EA78]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eli Carter <eli.carter@inet.com> wrote:
>
> If I can feed you changes to kgdb, would you be interested in taking 
> them?

Sure.

> What was the last patch you shipped with George's version?

Long time ago.  I'll send you the latest.

> Which do you think would be the right place to start?

George's.  It enters the debugger way earlier in boot and appears to have
stronger SMP support.  Has more features, etc.

> "We"... I like that word.  ;)  If you can act as 'upstream' for my 
> changes and answer quick questions, I'll feed you patches.

Sure.  The patches are against base 2.5.x, so your work will be separated
from -mm goings-on.

> I'm thinking I'll try to wind up with 2 or 3 patches, kgdb.patch, 
> kgdb-arm.patch, and kgdb-ia32.patch.  Maybe.

That sounds appropriate.


