Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVBGT2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVBGT2g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVBGT2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:28:36 -0500
Received: from canuck.infradead.org ([205.233.218.70]:14861 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261245AbVBGT2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:28:33 -0500
Subject: Re: [PATCH] PCI Hotplug: remove incorrect rpaphp firmware
	dependency
From: David Woodhouse <dwmw2@infradead.org>
To: John Rose <johnrose@austin.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com.torvalds, akpm@osdl.org
In-Reply-To: <1107798068.31219.6.camel@sinatra.austin.ibm.com>
References: <200502031908.j13J8ggb031915@hera.kernel.org>
	 <1107795637.19262.426.camel@hades.cambridge.redhat.com>
	 <1107798068.31219.6.camel@sinatra.austin.ibm.com>
Content-Type: text/plain
Date: Mon, 07 Feb 2005 19:28:25 +0000
Message-Id: <1107804505.19262.430.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-07 at 11:41 -0600, John Rose wrote:
> BTW, you're running an RPA module on your G5?

Fedora uses the same ppc64 kernel for both pSeries and G5.

-- 
dwmw2

