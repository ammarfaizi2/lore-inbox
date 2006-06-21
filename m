Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751937AbWFUCdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbWFUCdv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 22:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbWFUCdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 22:33:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64212 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751937AbWFUCdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 22:33:13 -0400
Date: Tue, 20 Jun 2006 19:32:33 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: rmk+lkml@arm.linux.org.uk, gregkh@suse.de, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       zaitcev@redhat.com
Subject: Re: Serial-Core: USB-Serial port current issues.
Message-Id: <20060620193233.15224308.zaitcev@redhat.com>
In-Reply-To: <20060620161134.20c1316e@doriath.conectiva>
References: <20060613192829.3f4b7c34@home.brethil>
	<20060614152809.GA17432@flint.arm.linux.org.uk>
	<20060620161134.20c1316e@doriath.conectiva>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 16:11:34 -0300, "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> wrote:

>  Pete, was it your original idea to completely move from the spinlock
> to a mutex?

I thought it was the cleanest solution. But perhaps I miss something.
I'll look at your reposted patch again, maybe it's all right as it is.

-- Pete
