Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277188AbRKHMSS>; Thu, 8 Nov 2001 07:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276894AbRKHMSI>; Thu, 8 Nov 2001 07:18:08 -0500
Received: from uucp.cistron.nl ([195.64.68.38]:61449 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S277246AbRKHMRw>;
	Thu, 8 Nov 2001 07:17:52 -0500
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: IDE byte counting
Date: Thu, 8 Nov 2001 12:17:51 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9sdt5f$32g$2@ncc1701.cistron.net>
In-Reply-To: <20011108103659.24f75c30.imolton@clara.net>
X-Trace: ncc1701.cistron.net 1005221871 3152 195.64.65.67 (8 Nov 2001 12:17:51 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011108103659.24f75c30.imolton@clara.net>,
Ian Molton  <spyro@armlinux.org> wrote:
>Is it possible to get a count of how much data has been read / written to
>an IDE device?
>I thought it'd be neat to modify one of the multitude of netload applaets
>to do 'diskload', but Im not sure the kernel provides such data.

/proc/stat

Mike.
-- 
"Only two things are infinite, the universe and human stupidity,
 and I'm not sure about the former" -- Albert Einstein.

