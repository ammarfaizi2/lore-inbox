Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270857AbRHSWim>; Sun, 19 Aug 2001 18:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270851AbRHSWic>; Sun, 19 Aug 2001 18:38:32 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:8932 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S270848AbRHSWiQ>;
	Sun, 19 Aug 2001 18:38:16 -0400
Date: Sun, 19 Aug 2001 23:38:28 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: David Schwartz <davids@webmaster.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Oliver Xymoron <oxymoron@waste.org>, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: RE: Entropy from net devices - keyboard & IDE just as 'bad' [was
 Re: [PATCH] let Net Devices feed Entropy, updated (1/2)]
Message-ID: <483044230.998264308@[169.254.45.213]>
In-Reply-To: <NOEJJDACGOHCKNCOGFOMEEOCDEAA.davids@webmaster.com>
In-Reply-To: <NOEJJDACGOHCKNCOGFOMEEOCDEAA.davids@webmaster.com>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	To what level of accuracy do you think you can measure when interrupts
> occur?

Better than the necessary 1 jiffie on non-i386 platforms and some
i386 platforms.

--
Alex Bligh
