Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281438AbRKLMyI>; Mon, 12 Nov 2001 07:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281449AbRKLMx7>; Mon, 12 Nov 2001 07:53:59 -0500
Received: from pa160.grajewo.sdi.tpnet.pl ([217.96.134.160]:31616 "HELO
	pa160.grajewo.sdi.tpnet.pl") by vger.kernel.org with SMTP
	id <S281438AbRKLMxr>; Mon, 12 Nov 2001 07:53:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Gniazdowski <refuse7@poczta.fm>
Reply-To: refuse7@poczta.fm
Organization: none
To: <linux-kernel@vger.kernel.org>
Subject: reseting /dev/tty
Date: Mon, 12 Nov 2001 14:01:08 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011112130108.0A9C417DC3@pa160.grajewo.sdi.tpnet.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Some time ago i had some problem. When i was working under XFree and it did 
crash in some special way, my screen was lockt, ctrl-alt-fX was not working.
SAK was killing XServer and others on tty7. Butt screen was still looking 
like window manager screen shot. When i blindly login and typed startx XFree 
was starting and working ok.
Butt all others consoles was corrupt, looking like X screen shot. My solution 
was to start use framebuffer on the console (tdfx) and fbset. Console always 
returns.
Howewer my brother has nvidia gf2mx card, and there is no frame buffer for 
it. Many other cards does not have fbuffer support. So finaly the question:
is there a way to reset /dev/tty ?


Regard Gniazdowski.
