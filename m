Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbTJAK3j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 06:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbTJAK3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 06:29:39 -0400
Received: from gprs146-6.eurotel.cz ([160.218.146.6]:36992 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261685AbTJAK3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 06:29:38 -0400
Date: Wed, 1 Oct 2003 12:26:31 +0200
From: Pavel Machek <pavel@suse.cz>
To: Makan Pourzandi <Makan.Pourzandi@ericsson.ca>
Cc: linux-kernel@vger.kernel.org,
       Axelle Apvrille <Axelle.Apvrille@ericsson.ca>,
       Vincent Roy <vincent.roy@ericsson.ca>,
       David Gordon <davidgordonca@yahoo.ca>, socrate@infoiasi.ro
Subject: Re: [ANNOUNCE] DigSig 0.2: kernel module for digital signature verification for binaries
Message-ID: <20031001102631.GC398@elf.ucw.cz>
References: <3F733FD3.60502@ericsson.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F733FD3.60502@ericsson.ca>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> overview
> =======
> 
> Instead of writing a long detailed explication, I rather give you an 
> example of how you can use it.

Can you also add example *why* one would want to use it?

AFAICS if I want to exec something, I can avoid exec() syscall and do
mmaps by hand...
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
