Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129550AbRBAWfQ>; Thu, 1 Feb 2001 17:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129567AbRBAWfG>; Thu, 1 Feb 2001 17:35:06 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:54021 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129550AbRBAWex>; Thu, 1 Feb 2001 17:34:53 -0500
Date: Thu, 1 Feb 2001 22:33:46 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Pavel Machek <pavel@suse.cz>
cc: Joe deBlaquiere <jadb@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <20010201134005.A119@bug.ucw.cz>
Message-ID: <Pine.LNX.4.30.0102012202040.1102-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001, Pavel Machek wrote:

> I thought that Vtech Helio folks already have XIP supported...

Plenty of people are doing XIP of the kernel. I'm not aware of anyone 
doing XIP of userspace pages. 

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
