Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWAINVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWAINVm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 08:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWAINVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 08:21:42 -0500
Received: from wscnet.wsc.cz ([212.80.64.118]:18567 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1751410AbWAINVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 08:21:42 -0500
Message-ID: <43C26357.9050301@liberouter.org>
Date: Mon, 09 Jan 2006 14:21:27 +0100
From: Jiri Slaby <slaby@liberouter.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Weber Ress <ress.weber@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel Education
References: <9c2327970601090500i78fec178mb197c0fa5732e4a4@mail.gmail.com>
In-Reply-To: <9c2327970601090500i78fec178mb197c0fa5732e4a4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Weber Ress napsal(a):
> Hi guys,
> 
> I´m starting a social project to teach kernel development for young
> students, with objetive of include these people in job market.
:)
> 
> These studentes don´t have great skills in mathematical and computer
> science areas, but have great interest in development area. Some
> studentes have a little basic C language skills.
> 
> Which are the first steps that I need in this project ?
prepare slides for teaching them real-world-(gc)c, not basic.
> Which´s the "more simple" kernel version to teach (2.2 ? 2.4 ? 2.6 ?).
IMHO 2.6 has the clearest api (specific(a) rather than sth. like
a->private->b->private.specific).
But in general it's hard to say this is the simplest one. In 2.2 there is less
code, than in 2.6 and so on

regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
