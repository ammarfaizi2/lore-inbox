Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267467AbRGLKek>; Thu, 12 Jul 2001 06:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267468AbRGLKeb>; Thu, 12 Jul 2001 06:34:31 -0400
Received: from babel.spoiled.org ([212.84.234.227]:26421 "HELO
	babel.spoiled.org") by vger.kernel.org with SMTP id <S267467AbRGLKeY>;
	Thu, 12 Jul 2001 06:34:24 -0400
Date: 12 Jul 2001 10:34:24 -0000
Message-ID: <20010712103424.21260.qmail@babel.spoiled.org>
From: Juri Haberland <juri@koschikode.com>
To: ionut@cs.columbia.edu (Ion Badulescu)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] starfire net driver update
X-Newsgroups: spoiled.linux.kernel
In-Reply-To: <Pine.LNX.4.33.0107112349390.17462-100000@age.cs.columbia.edu>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (OpenBSD/2.9 (i386))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:

> Actually, try this patch first. I believe it will fix your problems, but
> I'd like to confirm it.

Yep, this worked.
Btw, at what log-level is the link status printed?
I only got it via dmesg, but not in the logs. FWIW:
eth2: Link is down
eth5: Link is down
eth2: Link is up, running at 100Mbit half-duplex
eth5: Link is up, running at 100Mbit half-duplex

Juri

-- 
Juri Haberland  <juri@koschikode.com> 

