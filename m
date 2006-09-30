Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWI3KcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWI3KcS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 06:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWI3KcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 06:32:17 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:16840 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750779AbWI3KcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 06:32:16 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 1/6]: powerpc/cell spidernet burst alignment patch.
Date: Sat, 30 Sep 2006 12:29:00 +0200
User-Agent: KMail/1.9.1
Cc: jeff@garzik.org, akpm@osdl.org, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
References: <20060929230552.GG6433@austin.ibm.com> <20060929231511.GI6433@austin.ibm.com>
In-Reply-To: <20060929231511.GI6433@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609301229.00862.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Saturday 30 September 2006 01:15 schrieb Linas Vepstas:
> This patch increases the Burst Address alignment from 64 to 1024 in the
> Spidernet driver. This improves transmit performance for large packets.
>
> From: James K Lewis <jklewis@us.ibm.com>
> Signed-off-by: James K Lewis <jklewis@us.ibm.com>
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
