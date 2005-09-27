Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbVI0INV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbVI0INV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 04:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbVI0INV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 04:13:21 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:45964 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S964855AbVI0INU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 04:13:20 -0400
Message-ID: <4338FEB1.3090403@cs.aau.dk>
Date: Tue, 27 Sep 2005 10:11:29 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Automatic Configuration of a Kernel
References: <20050926120850.30349.qmail@web51012.mail.yahoo.com> <2cd57c9005092701055f96e629@mail.gmail.com>
In-Reply-To: <2cd57c9005092701055f96e629@mail.gmail.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> 
> Consider also 'm'odule support?

I think the point of a script is just to detect if the piece of hardware
is here or not ('y' or 'n'). Then, it's up to the interface to decide
what question to ask to the user (could be always 'y', could be always
'm', could ask the user for a 'm/y/n' answer, ...).

But the patches that Ahmad sent have been spoiled by his mailer, I think
he will resend it today (maybe creating a fresh thread would be a good
idea).

Regards
-- 
Emmanuel Fleury

I can resist everything except temptation.
  -- Oscar Wilde
