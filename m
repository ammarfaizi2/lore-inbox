Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270636AbTGPMSN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 08:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270652AbTGPMSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 08:18:13 -0400
Received: from [217.222.53.238] ([217.222.53.238]:56080 "EHLO mail.gts.it")
	by vger.kernel.org with ESMTP id S270636AbTGPMSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 08:18:11 -0400
Message-ID: <3F1545FD.5060801@gts.it>
Date: Wed, 16 Jul 2003 14:33:01 +0200
From: Stefano Rivoir <s.rivoir@gts.it>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J. Hidding" <J.Hidding@student.rug.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.0-test1 freezes sometimes
References: <web-8138438@mail.rug.nl>
In-Reply-To: <web-8138438@mail.rug.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J. Hidding wrote:

> Hello,
> 
> linux-2.6.0-test1 freezes quite often. I think it's 
> related with running a verry nasty Mozilla 1.4, but it's 
> only a hunch. Is anybody else experiencing this problem?

Yes, me :(

They seem to be totally random (no mozilla, here): I use KDE
and they may occur while scrolling down a window, or while
typing in a shell session or whatever.

I couldn't find a way to reproduce it so far.

Note that they did not happen up to kernel 2.5.75, and they
show up with 2.6.0-t1 and 2.6.0-t1-mm1.

No clues in syslog or kern.log, simply a sudden hard freeze,
without particular HD or CPU activity before.

Bye!

-- 
Stefano RIVOIR
GTS Srl



