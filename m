Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265478AbUAMV5i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 16:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265557AbUAMV5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 16:57:38 -0500
Received: from gprs214-177.eurotel.cz ([160.218.214.177]:2432 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265478AbUAMV5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 16:57:37 -0500
Date: Tue, 13 Jan 2004 22:57:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: root@chaos.analogic.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PATCH 1/2: Make gotoxy & siblings use unsigned variables
Message-ID: <20040113215727.GA211@elf.ucw.cz>
References: <1073672901.2069.15.camel@laptop-linux> <Pine.LNX.4.53.0401091415430.571@chaos> <1073677435.2069.23.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073677435.2069.23.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> You might be right. I was just being consistent with the other
> definitions. Andrew? Benjamin?

I believe size_t is meant for file size, memory size and similar. You
should stuck with int.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
