Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272510AbRIKQHQ>; Tue, 11 Sep 2001 12:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272511AbRIKQHG>; Tue, 11 Sep 2001 12:07:06 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:14020 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S272510AbRIKQGx>;
	Tue, 11 Sep 2001 12:06:53 -0400
Date: Tue, 11 Sep 2001 17:07:13 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Andreas Dilger <adilger@turbolabs.com>,
        Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: linux-2.4.10-pre5
Message-ID: <1033942741.1000228033@[10.132.112.53]>
In-Reply-To: <20010911155953Z16272-1367+16@humbolt.nl.linux.org>
In-Reply-To: <20010911155953Z16272-1367+16@humbolt.nl.linux.org>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Tuesday, September 11, 2001 6:07 PM +0200 Daniel Phillips 
<phillips@bonn-fries.net> wrote:

> There is clearly something nonoptimal about the hardware readahead and/or
> caching.

Partly I guess that the disk h/w cache is the wrong side of a potential
IO bottleneck - i.e. you can read faster from main memory than from
any disk cache.

--
Alex Bligh
