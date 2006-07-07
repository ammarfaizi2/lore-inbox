Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbWGGH5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWGGH5o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 03:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWGGH5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 03:57:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14547 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751060AbWGGH5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 03:57:43 -0400
Date: Fri, 7 Jul 2006 00:57:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: christoph@lameter.com, schwidefsky@de.ibm.com, geraldsc@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] vmstat: export all_vm_events()
Message-Id: <20060707005712.1560d1cf.akpm@osdl.org>
In-Reply-To: <20060707074525.GA9480@osiris.boeblingen.de.ibm.com>
References: <20060707074525.GA9480@osiris.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006 09:45:25 +0200
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> +EXPORT_SYMBOL(all_vm_events);

I converted this to _GPL if that's OK.

Don't know why, really.  Just to save wear and tear on Arjan's email client
I guess.

