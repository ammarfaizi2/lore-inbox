Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265134AbTAEVHx>; Sun, 5 Jan 2003 16:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265169AbTAEVHw>; Sun, 5 Jan 2003 16:07:52 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:49114 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S265134AbTAEVHw>;
	Sun, 5 Jan 2003 16:07:52 -0500
Subject: Re: [2.5.54 - Oops] CPUFreq [Was: Re: [2.5.54] OOPS: unable to
From: Steven Barnhart <sbarn03@softhome.net>
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030105195445.AD456437D@ritz.dnsalias.org>
References: <20030105195445.AD456437D@ritz.dnsalias.org>
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Jan 2003 16:16:19 -0500
Message-Id: <1041801384.6490.4.camel@sbarn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-05 at 13:54, Daniel Ritz wrote:
> looking at the oops it seems that it's the bufferoverflow in kallsyms_lookup.
> you are using 2.5.54 vanilla, aren't you.
> i already posted the patch for that which linus included. try to download the bk1
> snapshot (or higher) or just apply the following patch....
> 
> beep
> -daniel
Thanks daniel, just did a pull..will be in touch.

Steven
sbarn03@softhome.net
GnuPG Fingerprint: 9357 F403 B0A1 E18D 86D5  2230 BB92 6D64 D516 0A94

