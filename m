Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132400AbRDHBtI>; Sat, 7 Apr 2001 21:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132418AbRDHBs6>; Sat, 7 Apr 2001 21:48:58 -0400
Received: from ns.suse.de ([213.95.15.193]:24330 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132400AbRDHBsq>;
	Sat, 7 Apr 2001 21:48:46 -0400
Date: Sun, 8 Apr 2001 03:48:44 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Trevor Hemsley <Trevor-Hemsley@dial.pipex.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: P-III Oddity.
In-Reply-To: <20010407225637Z132049-494+49@vger.kernel.org>
Message-ID: <Pine.LNX.4.30.0104080346530.16508-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Apr 2001, Trevor Hemsley wrote:

> I've got this on my dual processor P-III 600MHz. One of the cpus in
> this box reports cpuid level 2, the other 3. Serial number is disabled
> in the BIOS.

Interesting, the cpu serial number isn't being disabled on the
2nd CPU. Most odd. Well, we disable reporting that it's available,
but it looks like it still remains possible to get at it.

I'll dig some more tomorrow morning.

Dave.

