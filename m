Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266351AbUGAWZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266351AbUGAWZe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 18:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUGAWZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 18:25:34 -0400
Received: from mid-1.inet.it ([213.92.5.18]:44165 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S266351AbUGAWZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 18:25:18 -0400
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA problems in 2.6.7-mm[1,5] vanilla works
Date: Fri, 2 Jul 2004 00:25:01 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200407012352.16816.cova@ferrara.linux.it> <40E48817.3060901@pobox.com>
In-Reply-To: <40E48817.3060901@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200407020025.02274.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 23:54, giovedì 1 luglio 2004, Jeff Garzik ha scritto:
> Fabio Coatti wrote:
> > I'm having problems with sata starting from 2.6.7-mm1:
> > the system hangs at boot, during the sata bus scan.
>
> does 'acpi=off' fix the problem?

Nope, just tried..I've also reverted bk-acpi patch, without any change. (on 
mm5)

-- 
Fabio Coatti       http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
