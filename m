Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751857AbWG0Cx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbWG0Cx7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 22:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWG0Cx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 22:53:57 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:9146 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751219AbWG0Cx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 22:53:56 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: Heiko Carstens <heiko.carstens@de.ibm.com>, vandrove@vc.cvut.cz,
       linware@sh.cvut.cz
Subject: Re: reference: ncpfs: move ioctl32 code to fs/ncpfs/ioctl.c
Date: Thu, 27 Jul 2006 04:53:52 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <20060710085142.GB9440@osiris.boeblingen.de.ibm.com> <200607270303.42959.arnd.bergmann@de.ibm.com> <200607270308.13007.arnd.bergmann@de.ibm.com>
In-Reply-To: <200607270308.13007.arnd.bergmann@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607270453.52985.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 July 2006 03:08, Arnd Bergmann wrote:
> Ok, I just realized that this was not using a merged 
> ->compat_ioctl/->unlocked_ioctl function yet, but wth, here
> it is anyway.
> 
Oh well, couldn't resist doing the complete patch now...

Petr, you can find the thread at http://lkml.org/lkml/2006/7/10/49

	Arnd <><
