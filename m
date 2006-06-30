Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751716AbWF3JbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbWF3JbJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 05:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751725AbWF3JbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 05:31:08 -0400
Received: from aa004msr.fastwebnet.it ([85.18.95.67]:9924 "EHLO
	aa004msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751716AbWF3JbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 05:31:07 -0400
Date: Fri, 30 Jun 2006 11:31:00 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Matt LaPlante <laplam@rpi.edu>
Cc: rdunlap@xenotime.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Attack of "the the"s in /arch
Message-ID: <20060630113100.007a0125@localhost>
In-Reply-To: <20060629125249.4ad83383.laplam@rpi.edu>
References: <000001c69b31$64186160$fe01a8c0@cyberdogt42>
	<20060628213924.50f29a4a.rdunlap@xenotime.net>
	<20060629011651.1543b42b.laplam@rpi.edu>
	<20060628230305.c9eaf6a9.rdunlap@xenotime.net>
	<20060629024805.63f8054c.laplam@rpi.edu>
	<20060629100457.4ed45d7e@localhost>
	<20060629125249.4ad83383.laplam@rpi.edu>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 12:52:49 -0400
Matt LaPlante <laplam@rpi.edu> wrote:

> Thanks for the pointer, I will do this from now on.  I was reading the patch submission info at http://www.kernel.org/pub/linux/docs/lkml/, and it does not suggest this (it goes Maintainer> Linus | Alan Cox), so I did not know.  Maybe this address could be added either to maintainers or the lkml page?

At the end of:
http://www.kernel.org/pub/linux/docs/lkml/

there's:
"Contributing
Contributions are welcome on this FAQ. These can be submitted,
preferably in diff -u format, (against this HTML document source) by
Email to Richard (see the Contributors section above).

Sometimes, we may feel your contribution is controversial and/or
incomplete and/or could be improved somehow. Also, the turnaround time
has a wide range, from hours to months, depending on how busy Richard
is. Please do not email him to chase changes as it slows him down.
Suggestions and patches are queued, and will be processed eventually.
Acknowledgements are usually sent when the change is made. Please be
patient, FAQ updates are rarely urgent. Note that small, "obviously
correct" patches are more likely to be processed faster, and often jump
the queue ahead of larger patches."

If you want to send a patch...

-- 
	Paolo Ornati
	Linux 2.6.17.1 on x86_64
