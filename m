Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316623AbSFDT3q>; Tue, 4 Jun 2002 15:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316635AbSFDT3p>; Tue, 4 Jun 2002 15:29:45 -0400
Received: from waste.org ([209.173.204.2]:43932 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S316623AbSFDT3o>;
	Tue, 4 Jun 2002 15:29:44 -0400
Date: Tue, 4 Jun 2002 14:29:41 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
In-Reply-To: <E17Eo76-0000rv-00@starship>
Message-ID: <Pine.LNX.4.44.0206041418460.2614-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2002, Daniel Phillips wrote:

> traditional IT.  Not to mention that I can look forward to a sound
> system where I can be *sure* my mp3s won't skip.

Not unless you're loading your entire MP3 into memory, mlocking it down,
and handing it off to a hard RT process. And then your control of the
playback of said song through a non-RT GUI could be arbitrarily coarse,
depending on load.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

