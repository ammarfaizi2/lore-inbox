Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267414AbTALT2A>; Sun, 12 Jan 2003 14:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267415AbTALT2A>; Sun, 12 Jan 2003 14:28:00 -0500
Received: from packet.digeo.com ([12.110.80.53]:11954 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267414AbTALT17> convert rfc822-to-8bit;
	Sun, 12 Jan 2003 14:27:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andrew Morton <akpm@digeo.com>
To: David Ford <david+cert@blue-labs.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.56 panics PostgreSQL
Date: Sun, 12 Jan 2003 11:37:07 -0800
User-Agent: KMail/1.4.3
References: <3E21B839.4060902@blue-labs.org>
In-Reply-To: <3E21B839.4060902@blue-labs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301121137.07735.akpm@digeo.com>
X-OriginalArrivalTime: 12 Jan 2003 19:36:42.0331 (UTC) FILETIME=[EEFB42B0:01C2BA71]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun January 12 2003 10:47, David Ford wrote:
>
> Yesterday I put 2.5.56 on my SQL server and PostgreSQL started panicking 
> repeatedly and frequently complaining about missing commit logs.

Which filesystems were in use?



