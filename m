Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132045AbRCVOzU>; Thu, 22 Mar 2001 09:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132037AbRCVOzB>; Thu, 22 Mar 2001 09:55:01 -0500
Received: from mailimailo.univ-rennes1.fr ([129.20.131.1]:65274 "EHLO
	mailimailo.univ-rennes1.fr") by vger.kernel.org with ESMTP
	id <S132045AbRCVOyx>; Thu, 22 Mar 2001 09:54:53 -0500
Date: Thu, 22 Mar 2001 17:15:42 +0100 (CET)
From: Thomas Speck <Thomas.Speck@univ-rennes1.fr>
To: Neal Gieselman <Neal.Gieselman@Visionics.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Where is the RAM?
In-Reply-To: <D0FA767FA2D5D31194990090279877DA5736B2@dbimail.digitalbiometrics.com>
Message-ID: <Pine.LNX.4.21.0103221714350.28686-100000@pc-astro.spm.univ-rennes1.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2001, Neal Gieselman wrote:

> I have a Redhat 6.1 WS that was installed with 64 MB RAM.  I added another
> 64 MB, booted, BIOS sees it, but top, free, etc still see only 64 MB.
> Any clues on what to do?

Maybe append="mem=128M" in lilo.conf helps ...

--
Thomas

