Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268099AbTBMRoS>; Thu, 13 Feb 2003 12:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268100AbTBMRoS>; Thu, 13 Feb 2003 12:44:18 -0500
Received: from packet.digeo.com ([12.110.80.53]:19865 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268099AbTBMRoS>;
	Thu, 13 Feb 2003 12:44:18 -0500
Date: Thu, 13 Feb 2003 09:54:19 -0800
From: Andrew Morton <akpm@digeo.com>
To: joakim.tjernlund@lumentis.se
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  crc32 improvements for 2.5 [RESEND]
Message-Id: <20030213095419.0d71f7d0.akpm@digeo.com>
In-Reply-To: <IGEFJKJNHJDCBKALBJLLKEDMFKAA.joakim.tjernlund@lumentis.se>
References: <1044365707.4067.4.camel@passion.cambridge.redhat.com>
	<IGEFJKJNHJDCBKALBJLLKEDMFKAA.joakim.tjernlund@lumentis.se>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Feb 2003 17:54:02.0790 (UTC) FILETIME=[E4D3E460:01C2D388]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joakim Tjernlund <joakim.tjernlund@lumentis.se> wrote:
>
> I did the optimizations in the crc32 patch Brian Murphy submitted a while ago.
> Now I have cleaned it up a little and made some more optimizations.

I added this to -mm, but I don't know how to test it ;)

What testing have you performed?  And have you any benchmark results?
