Return-Path: <linux-kernel-owner+w=401wt.eu-S1760298AbWLJHIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760298AbWLJHIt (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 02:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760321AbWLJHIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 02:08:49 -0500
Received: from smtp.osdl.org ([65.172.181.25]:57331 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760298AbWLJHIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 02:08:48 -0500
Date: Sat, 9 Dec 2006 23:08:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Liyu <raise.sail@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] freeze when poweroff
Message-Id: <20061209230845.072900ab.akpm@osdl.org>
In-Reply-To: <4579416C.1010407@gmail.com>
References: <4579416C.1010407@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 08 Dec 2006 18:41:48 +0800 Liyu <raise.sail@gmail.com> wrote:
>     I got a hasee notebook, and failed to poweroff after win soundcard
> (ALC861) problem.
> I seen someone said  acpi=off may help this, but when I append it on
> kernel parameter list, the kernel even can not boot, the kernel just
> said "hdc: lost interrupt" at last, and freezeing.

Please raise a report against acpi at bugzilla.kernel.org.
