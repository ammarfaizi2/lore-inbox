Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWI3KfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWI3KfY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 06:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWI3KfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 06:35:23 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:20172 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750794AbWI3KfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 06:35:20 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/6]: powerpc/cell spidernet stop error printing patch.
Date: Sat, 30 Sep 2006 12:32:04 +0200
User-Agent: KMail/1.9.1
Cc: Linas Vepstas <linas@austin.ibm.com>, jeff@garzik.org, akpm@osdl.org,
       netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
       linux-kernel@vger.kernel.org
References: <20060929230552.GG6433@austin.ibm.com> <20060929231922.GK6433@austin.ibm.com>
In-Reply-To: <20060929231922.GK6433@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609301232.04585.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Saturday 30 September 2006 01:19 schrieb Linas Vepstas:
> Turn off mis-interpretation of the queue-empty interrupt
> status bit as an error. This bit is set as a part of
> the previous low-watermark patch.
>
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> Signed-off-by: James K Lewis <jklewis@us.ibm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
