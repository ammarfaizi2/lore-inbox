Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbWHRWvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWHRWvU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 18:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422636AbWHRWvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 18:51:20 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:32472 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751494AbWHRWvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 18:51:18 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/6]: powerpc/cell spidernet burst alignment patch
Date: Sat, 19 Aug 2006 00:51:01 +0200
User-Agent: KMail/1.9.1
Cc: Linas Vepstas <linas@austin.ibm.com>, Jeff Garzik <jgarzik@pobox.com>,
       akpm@osdl.org, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       ens Osterkamp <Jens.Osterkamp@de.ibm.com>
References: <20060818220700.GG26889@austin.ibm.com> <20060818222038.GH26889@austin.ibm.com>
In-Reply-To: <20060818222038.GH26889@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608190051.03105.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 August 2006 00:20, Linas Vepstas wrote:
> This patch increases the Burst Address alignment from 64 to 1024 in the
> Spidernet driver. This improves transmit performance for arge packets
> from about 100Mbps to 300-400Mbps.

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
