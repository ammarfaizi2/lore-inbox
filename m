Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262825AbVAFNsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262825AbVAFNsE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 08:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbVAFNro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 08:47:44 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:55738 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262824AbVAFNqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 08:46:04 -0500
Subject: Re: [7/7] LEON SPARC V8 processor support for linux-2.6.10
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jiri Gaisler <jiri@gaisler.com>
Cc: sparclinux@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       wli@holomorphy.com
In-Reply-To: <41DC0572.60608@gaisler.com>
References: <41DAE8CC.3010904@gaisler.com>
	 <1104877702.17166.53.camel@localhost.localdomain>
	 <41DC0572.60608@gaisler.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104937418.17176.183.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 06 Jan 2005 12:41:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-01-05 at 15:19, Jiri Gaisler wrote:
> Leon2 serial+ethermac driver, updated.

Looks good to me. Fixes the serial code back up to current and removes
the problem code.

