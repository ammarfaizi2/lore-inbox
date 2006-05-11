Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751795AbWEKOfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbWEKOfO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 10:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWEKOfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 10:35:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60872 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751795AbWEKOfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 10:35:12 -0400
Date: Thu, 11 May 2006 07:32:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: acpi4asus
Message-Id: <20060511073211.1da40329.akpm@osdl.org>
In-Reply-To: <20060511130743.GG15876@mail.muni.cz>
References: <20060511130743.GG15876@mail.muni.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:
>
> Hello,
> 
> is project acpi4asus still alive?

I know of no such project.

> (I'm asking here whether Andrew or Linus are
> receiving patches from acpi guys). For me, it looks like this is somewhat dead.

Well actually I receive asus patches from various people and send them to
the acpi developers and nothing happens.  So I resend and eventually a few
stick.

The ACPI team are trying to get away from these machine-specific ACPI
drivers in favour of doing everything correctly within AML, but there
doesn't seem to be a lot of progress with that afaict.

> I posted patch to include Asus M6A support to both lkm and acpi4asus list but no
> response. I only noticed, that Andrew once tried to include in -mm but I did not
> see it there anyway.

Missed it - please resend.
