Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161128AbVIPIVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161128AbVIPIVf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 04:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161129AbVIPIVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 04:21:35 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:60587 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S1161128AbVIPIVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 04:21:35 -0400
Message-ID: <432A8026.5060509@cs.aau.dk>
Date: Fri, 16 Sep 2005 10:19:50 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Automatic Configuration of a Kernel
References: <20050914223836.53814.qmail@web51011.mail.yahoo.com> <2cd57c9005091601112e215a1e@mail.gmail.com>
In-Reply-To: <2cd57c9005091601112e215a1e@mail.gmail.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> 
> How about the idea that we have a .hwconfig file and we do `make
> hwconfig' to generate it? So normal filesystems and network stack
> stuff don't belong to hwconfig.
> 
> .hwconfig file merely stores the result from auto hardware detection.

Well, at the end you just want to have one .config file with everything
inside. If I follow your logic we also should have a .fsconfig, a
.netconfig, a .audioconfig, ... and so on.

So, working on the .config seems nice to me.

Simplicity is good ! ^_^

Regards
-- 
Emmanuel Fleury

A child of five could understand this. Fetch me a child of five.
  -- Groucho Marx
