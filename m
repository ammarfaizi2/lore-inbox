Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbTCJWHr>; Mon, 10 Mar 2003 17:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbTCJWHr>; Mon, 10 Mar 2003 17:07:47 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:29865 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP
	id <S261868AbTCJWHr>; Mon, 10 Mar 2003 17:07:47 -0500
Date: Tue, 11 Mar 2003 11:17:06 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: SWSUSP Discontiguous pagedir patch
In-reply-to: <20030310192300.GC11310@atrey.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Patrick Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1047334626.6245.30.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20030307202759.GA2447@elf.ucw.cz>
 <Pine.LNX.4.33.0303101012230.1002-100000@localhost.localdomain>
 <20030310192300.GC11310@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2003-03-11 at 08:23, Pavel Machek wrote:
> Do you think you can suspend with 90% memory kmalloc()-ed?

Is that a fair question? Would 90% of memory ever be kmalloced? If the
question is can you suspend with 90% of memory used, then I can answer
yes. I do it all the time under the code I'm porting to 2.5. (Nearly
there, by the way).

Regards,

Nigel

