Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVAEBFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVAEBFk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 20:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbVAEBFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 20:05:40 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:9399 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262091AbVAEBFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 20:05:35 -0500
Subject: Re: [1/7] LEON SPARC V8 processor support for linux-2.6.10
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jiri Gaisler <jiri@gaisler.com>
Cc: sparclinux@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       wli@holomorphy.com
In-Reply-To: <41DAE89A.6060009@gaisler.com>
References: <41DAE89A.6060009@gaisler.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104877412.17166.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 05 Jan 2005 00:01:12 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-04 at 19:03, Jiri Gaisler wrote
> + *  The license and distribution terms for this file may be
> + *  found in the file LICENSE in this distribution or at
> + *  http://www.rtems.com/license/LICENSE.

Legalese hat on

Please don't do this. Suppose the file changes or the site goes away.
Include a copy of the license in the patch set directly.

