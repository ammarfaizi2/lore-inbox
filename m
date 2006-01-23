Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWAWOL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWAWOL7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 09:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWAWOL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 09:11:59 -0500
Received: from smtp104.biz.mail.re2.yahoo.com ([206.190.52.173]:55942 "HELO
	smtp104.biz.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932106AbWAWOL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 09:11:58 -0500
In-Reply-To: <20060121210511.GD3456@linux-mips.org>
References: <20060119174600.GT19398@stusta.de> <20060121210511.GD3456@linux-mips.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2edd3641fe1cb18d25e35abe40de5d4e@embeddedalley.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       Adrian Bunk <bunk@stusta.de>, perex@suse.cz, linux-mips@linux-mips.org
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: RFC: OSS driver removal, a slightly different approach
Date: Mon, 23 Jan 2006 09:11:50 -0500
To: Ralf Baechle <ralf@linux-mips.org>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 21, 2006, at 4:05 PM, Ralf Baechle wrote:

> On Thu, Jan 19, 2006 at 06:46:00PM +0100, Adrian Bunk wrote:
>
>> 3. no ALSA drivers for the same hardware
> [...]
>> SOUND_AU1550_AC97

The Au1550 should have an ALSA driver.  It was done
some time ago.  Perhaps we just didn't submit it to the
proper maintainer.  I'll track that down.

	-- Dan

