Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265002AbSLQMd2>; Tue, 17 Dec 2002 07:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265008AbSLQMd2>; Tue, 17 Dec 2002 07:33:28 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:54422 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265002AbSLQMd1>;
	Tue, 17 Dec 2002 07:33:27 -0500
Date: Tue, 17 Dec 2002 12:40:09 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021217124009.GB10589@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andre Hedrick <andre@linux-ide.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	hpa@transmeta.com
References: <Pine.LNX.4.44.0212162140500.1644-100000@home.transmeta.com> <Pine.LNX.4.10.10212170144030.31876-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10212170144030.31876-100000@master.linux-ide.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 01:45:52AM -0800, Andre Hedrick wrote:
 
 > Are you serious about moving of the banging we currently do on 0x80?
 > If so, I have a P4 development board with leds to monitor all the lower io
 > ports and can decode for you.

INT 0x80 != IO port 0x80

8-)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
