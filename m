Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264629AbTF0SYS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 14:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264647AbTF0SYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 14:24:17 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:9710 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264629AbTF0SYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 14:24:14 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200306271838.h5RIcQh13694@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.21-ac4
To: szepe@pinerecords.com (Tomas Szepe)
Date: Fri, 27 Jun 2003 14:38:26 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20030627183633.GD21564@louise.pinerecords.com> from "Tomas Szepe" at Meh 27, 2003 08:36:33 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> $ ls -la patch-2.4.21-ac[34].gz
> -rw-r--r--    1 kala     users     2891908 Jun 25 18:32 patch-2.4.21-ac3.gz
> -rw-r--r--    1 kala     users     2891908 Jun 27 20:07 patch-2.4.21-ac4.gz
> $ diff patch-2.4.21-ac[34].gz

Intriguing. The joys of caching. Will go fix
