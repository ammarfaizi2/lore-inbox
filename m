Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTGTLT3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 07:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266930AbTGTLT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 07:19:29 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:20138 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S262123AbTGTLT2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 07:19:28 -0400
Date: Sun, 20 Jul 2003 13:33:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: linux-kernel@vger.kernel.org, torvalds@osdl.com
Subject: Re: [PATCH] Compile fix for suspend.c
Message-ID: <20030720113352.GA269@elf.ucw.cz>
References: <20030720092314.GA11395@himi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030720092314.GA11395@himi.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> kernel/suspend.c fails to build as of a bk pull at about 08:00 UTC,
> with redefinitions of _text.
> 
> The attached patch fixes the build.

Can you send me your config? I did checkout from bkcvs, and it seems
to compile okay.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
