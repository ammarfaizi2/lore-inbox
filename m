Return-Path: <linux-kernel-owner+w=401wt.eu-S1422724AbWLUFNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422724AbWLUFNZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 00:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422728AbWLUFNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 00:13:25 -0500
Received: from smtp.osdl.org ([65.172.181.25]:38750 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422724AbWLUFNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 00:13:24 -0500
Date: Wed, 20 Dec 2006 21:13:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miguel Ojeda Sandonis <maxextreme@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH update9] drivers: add LCD support
Message-Id: <20061220211322.cc5661f3.akpm@osdl.org>
In-Reply-To: <20061220151000.27602c37.maxextreme@gmail.com>
References: <20061220151000.27602c37.maxextreme@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006 15:10:00 +0100
Miguel Ojeda Sandonis <maxextreme@gmail.com> wrote:

> Andrew, another one for drivers-add-lcd-support saga. Thanks you.

This patch appears to be against some private tree of yours, not against -mm.

Which tells me that it hasn't been tested against the patches in -mm and,
more importantly, that probably nobody is testing the patches which are
in -mm.

I'd prefer that you do so, please - there's always a possibility that the 
patches got mangled in flight, or that some other pending change in -mm
means that the patches work in your tree, but won't work when I merge them
up.

Thanks.
