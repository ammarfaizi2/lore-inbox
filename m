Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267474AbTBFSFF>; Thu, 6 Feb 2003 13:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267476AbTBFSFE>; Thu, 6 Feb 2003 13:05:04 -0500
Received: from uswest-dsl-142-38.cortland.com ([209.162.142.38]:4358 "HELO
	warez.scriptkiddie.org") by vger.kernel.org with SMTP
	id <S267474AbTBFSFE>; Thu, 6 Feb 2003 13:05:04 -0500
Date: Thu, 6 Feb 2003 10:14:41 -0800 (PST)
From: Lamont Granquist <lamont@scriptkiddie.org>
To: Stephen Clark <sclark46@earthlink.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: NAT counting
In-Reply-To: <3E427554.1030701@earthlink.net>
Message-ID: <20030206101319.P14724-100000@coredump.scriptkiddie.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If anyone is working on fixing this, they'll also need to fix up TCP
timestamps and maybe ISNs as well as IPids.

On Thu, 6 Feb 2003, Stephen Clark wrote:
> Hi all,
>
> Is Linux being fixed to prevent this?
>
>
> "how to remotely count the number of machines hiding behind a NAT box"
> <http://www.research.att.com/%7Esmb/papers/fnat.pdf> /
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

