Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbWFYXsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWFYXsy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 19:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWFYXsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 19:48:54 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:42744 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964904AbWFYXsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 19:48:54 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/5] spufs: fix spufs_mfc_flush prototype
Date: Mon, 26 Jun 2006 01:48:40 +0200
User-Agent: KMail/1.9.1
Cc: paulus@samba.org, cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <20060623185746.037897000@klappe.arndb.de> <20060623185825.158050000@klappe.arndb.de>
In-Reply-To: <20060623185825.158050000@klappe.arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606260148.41268.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 June 2006 20:57, arnd@arndb.de wrote:
> The prototype for the flush file operation now has another
> argument in 2.6.18.

Al Viro already submitted this one, please ignore it.

	Arnd <><
