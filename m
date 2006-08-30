Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWH3NMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWH3NMp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 09:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbWH3NMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 09:12:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65433 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750996AbWH3NMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 09:12:44 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060830124356.567568000@klappe.arndb.de> 
References: <20060830124356.567568000@klappe.arndb.de> 
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Jeff Dike <jdike@addtoit.com>, Bjoern Steinbrink <B.Steinbrink@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Andi Kleen <ak@suse.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 0/6] kill __KERNEL_SYSCALLS__, try #3 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 30 Aug 2006 14:12:11 +0100
Message-ID: <19389.1156943531@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Compiles and runs okay on FRV.

Acked-By: David Howells <dhowells@redhat.com>
