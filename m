Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261558AbTCOUfO>; Sat, 15 Mar 2003 15:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261556AbTCOUfN>; Sat, 15 Mar 2003 15:35:13 -0500
Received: from [195.39.17.254] ([195.39.17.254]:20740 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261554AbTCOUfL>;
	Sat, 15 Mar 2003 15:35:11 -0500
Date: Sat, 15 Mar 2003 20:46:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ed Vance <EdV@macrolink.com>
Cc: "'Linux PPP'" <linuxppp@indiainfo.com>, linux-serial@vger.kernel.org,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: RS485 communicatio
Message-ID: <20030315194646.GB367@elf.ucw.cz>
References: <11E89240C407D311958800A0C9ACF7D1A33DDF@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A33DDF@EXCHANGE>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I will be grateful if anybody of them could help me with my 
> > current problem.
> > 
> 
> I believe Point-to-Point Protocol only supports point-to-point symmetric
> links. Don't think there is any multi-point support in the protocol. IIRC,
> PPP also requires a full duplex link, which is not available on an RS-485
> link with more than two stations, even if it is a 4-wire link. 

Get scarabd (I don't know *where* it is), it can run TCP/IP over slip over
half-duplex link. Performance is not too good.
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
