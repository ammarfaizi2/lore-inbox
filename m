Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbTLSVh2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 16:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTLSVh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 16:37:28 -0500
Received: from mother.ds.pg.gda.pl ([153.19.213.213]:59191 "HELO
	mother.ds.pg.gda.pl") by vger.kernel.org with SMTP id S263580AbTLSVh1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 16:37:27 -0500
Date: Fri, 19 Dec 2003 22:37:34 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6-test11 framebuffer Matrox
Message-ID: <20031219213734.GA27975@irc.pl>
Mail-Followup-To: Tomasz Torcz <zdzichu@irc.pl>,
	linux-kernel@vger.kernel.org
References: <200312190314.13138.schwientek@web.de> <3FE2B717.7020502@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE2B717.7020502@convergence.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 19, 2003 at 09:30:15AM +0100, Michael Hunold wrote:
> Can somebody definately say if "matroxfb" is working for 2.6? I haven't 
> tested it for a while, but I was surprised to find it non-working in 2.6...

 Not working for me. G550 driving Samsung SyncMaster 171s (LCD).
It locked system several times in the past when switching between XFree
and fb console.
 I was told to use exact resolution and color depth wi fbcon and X.
In my case, it's 1280x1024-16bpp. It is working great in X, but
fbcon do not work - all I get is a black screen and lock when
I try to blinfly run XFree.

-- 
Tomasz Torcz            There exists no separation between gods and men:
zdzichu@irc.-nie.spam-.pl   one blends softly casual into the other. 
|> Playing: Marlow - exposed_(frankman_remix) ...
