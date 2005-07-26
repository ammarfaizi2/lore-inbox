Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVGZP2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVGZP2K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 11:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVGZP2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 11:28:10 -0400
Received: from vmlinux.org ([193.41.214.66]:37301 "EHLO vmlinux.org")
	by vger.kernel.org with ESMTP id S261826AbVGZP2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 11:28:08 -0400
Message-ID: <42E6567C.8090402@vmlinux.org>
Date: Tue, 26 Jul 2005 17:27:56 +0200
From: Joachim Nilsson <joachim.nilsson@vmlinux.org>
Organization: vmlinux:~/
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>,
       roms@lpg.ticalc.org
Subject: Re: RFT - gconfig fix
References: <20050726120841.GA27366@mars.ravnborg.org>
In-Reply-To: <20050726120841.GA27366@mars.ravnborg.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> Joachim - any specific reason why you ifdeffed out usage of stock Gtk icons?

Only to have a consistent look between xconfig and gconfig.

A better way would perhaps be to use stock KDE and GNOME icons, but I
never had the time to make a fix for xconfig so I made this compromise
instead to let you guys chose/code for me.  Personally I prefer the
in-kernel icons though...

Regards
 /Jocke

-- 
Joachim Nilsson :: <joachim AT vmlinux DOT org>
+46(0)21-123348 :: <http://vmlinux.org/joachim/>
