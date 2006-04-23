Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWDWQvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWDWQvn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 12:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWDWQvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 12:51:43 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:18938 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751425AbWDWQvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 12:51:42 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] 'make headers_install' kbuild target.
Date: Sun, 23 Apr 2006 18:51:00 +0200
User-Agent: KMail/1.9.1
Cc: David Woodhouse <dwmw2@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, sam@ravnborg.org, mschwid2@de.ibm.com
References: <1145672241.16166.156.camel@shinybook.infradead.org> <200604222313.42976.arnd@arndb.de> <1145776170.3131.4.camel@laptopd505.fenrus.org>
In-Reply-To: <1145776170.3131.4.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604231851.01109.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sunday 23 April 2006 09:09 schrieb Arjan van de Ven:
> > atomic.h
>
> this one for sure isn't for userspace; simply because at least on x86 it
> isn't atomic there (well depending on the phase of the moon) and for
> some it can't be done at all.

Right, my mistake.

	Arnd <><
