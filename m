Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272268AbRH3Pa3>; Thu, 30 Aug 2001 11:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272272AbRH3PaK>; Thu, 30 Aug 2001 11:30:10 -0400
Received: from [209.202.108.240] ([209.202.108.240]:35601 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S272268AbRH3PaA>; Thu, 30 Aug 2001 11:30:00 -0400
Date: Thu, 30 Aug 2001 11:30:05 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: ATAPI Floppy Problem
In-Reply-To: <3B8E5A50.3040703@nyc.rr.com>
Message-ID: <Pine.LNX.4.33.0108301129080.29615-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001, John Weber wrote:

> I get the following error on reboot...
>
> Aug 30 02:31:17 boolean kernel: ide-floppy: hdc: I/O error, pc = 5a, key
> =  5, asc = 24, ascq =  0
>
> I have a ZIP 100, and am currently using ide-floppy driver 0.97
> (included with linux 2.4.9).
>
> Suggestions?

Do you have media in the drive? The only time I've ever seen that is with my
LS-120 when there's no disk in it. If that's the case then you can ignore it.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

