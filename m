Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbVGVVUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbVGVVUp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 17:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVGVVUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 17:20:30 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:54985 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262181AbVGVVSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 17:18:53 -0400
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Johannes Stezenbach <js@linuxtv.org>, Adrian Bunk <bunk@stusta.de>
Subject: Re: Why build empty object files in drivers/media?
References: <200507212309_MC3-1-A534-95EE@compuserve.com>
	<20050722194600.GA8757@mars.ravnborg.org>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Fri, 22 Jul 2005 23:18:13 +0200
Message-ID: <87oe8uleui.fsf@goat.bogus.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

> +obj-$(CONFIG_VIDEO_DEV) := video/
> +obj-$(CONFIG_VIDEO_DEV) := radio/

  s/VIDEO/RADIO/

Regards, Olaf.
