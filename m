Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVDZBGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVDZBGc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 21:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVDZBGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 21:06:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:13704 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261254AbVDZBGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 21:06:31 -0400
Date: Mon, 25 Apr 2005 18:06:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, eike-kernel@sf-tec.de
Subject: Re: 2.6.12-rc2-mm3
Message-Id: <20050425180606.5e51ee25.akpm@osdl.org>
In-Reply-To: <20050425174900.688f18fa.rddunlap@osdl.org>
References: <20050411012532.58593bc1.akpm@osdl.org>
	<20050425174900.688f18fa.rddunlap@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
> 
> 
>  I'm seeing some badness and a panic, goes away if I disable
>  PCI Express.

OK, it looks like Greg's stuff broke.  I'm not in much of a position to
think about this at present - please keep an eye on things as -mm ramps up
again, remind us if it's still happening?

