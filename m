Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264523AbRFUBxI>; Wed, 20 Jun 2001 21:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264544AbRFUBwt>; Wed, 20 Jun 2001 21:52:49 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:38156 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264523AbRFUBwq>; Wed, 20 Jun 2001 21:52:46 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: is there a linux running on jvm arch ?
Date: 20 Jun 2001 18:52:24 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9grk0o$3sf$1@cesium.transmeta.com>
In-Reply-To: <3B311519.3090401@free.fr> <E15CqCJ-0000Co-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E15CqCJ-0000Co-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
> 
> The JVM is very very bad from a C language point of view. You can convert C
> code to it and there have been some very experimental demos of this. However
> it is a very non trivial problem
> 

Note that PicoJava is basically the JVM with a few extensions to run C
code reasonably.  It might be a better target.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
