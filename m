Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263122AbTDBSd1>; Wed, 2 Apr 2003 13:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263126AbTDBSd1>; Wed, 2 Apr 2003 13:33:27 -0500
Received: from smtp02.web.de ([217.72.192.151]:42774 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S263122AbTDBSd0>;
	Wed, 2 Apr 2003 13:33:26 -0500
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: Mitch Adair <mitch@theneteffect.com>
Subject: Re: subsystem crashes reboot system?
Date: Wed, 2 Apr 2003 20:44:27 +0200
User-Agent: KMail/1.5
References: <200304021806.h32I6M709795@mako.theneteffect.com>
In-Reply-To: <200304021806.h32I6M709795@mako.theneteffect.com>
Cc: rmiller@duskglow.com (Russell Miller), linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304022044.27530.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 April 2003 20:06, Mitch Adair wrote:

> Isn't this what watchdog is for?  I think even the software watchdog would
> catch this, then you can panic and reboot.

hm, I don't think, that watchdog will catch this, because the userspace-watchdog
daemon will still be running properly in a crash case
(or did I understand something wrong?)

Regards Michael Buesch.

-- 
-------------
My homepage: http://www.8ung.at/tuxsoft
fighting for peace is like fu**ing for virginity

