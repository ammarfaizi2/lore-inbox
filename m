Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265655AbSKASZ4>; Fri, 1 Nov 2002 13:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265658AbSKASZ4>; Fri, 1 Nov 2002 13:25:56 -0500
Received: from mail.gurulabs.com ([208.177.141.7]:42205 "EHLO
	mail.gurulabs.com") by vger.kernel.org with ESMTP
	id <S265655AbSKASZ4>; Fri, 1 Nov 2002 13:25:56 -0500
Subject: Filesystem Capabilities in 2.6?
From: Dax Kelson <dax@gurulabs.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, davej@suse.de
In-Reply-To: <20021101085148.E105A2C06A@lists.samba.org>
References: <20021101085148.E105A2C06A@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Nov 2002 11:32:43 -0700
Message-Id: <1036175565.2260.20.camel@mentor>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2002-11-01 at 01:49, Rusty Russell wrote:
> I'm down to 8 undecided features: 6 removed and one I missed earlier.

How about Olaf Dietsche's filesystem capabilities support? It has been
posted a couple times to LK, yesterday even.


We've had capabilities for ages (2.2?) but no filesystem support.

OpenBSD is recently bragging about no longer having any SUID root
binaries on the system.

With FS capabilities we (Linux) can have the same situation.  Security
is a hot topic, and anything the kernel can do make security
better/easier seems worthy of consideration.

Dax Kelson


